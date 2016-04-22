package com.pycsh.action;

import com.pycsh.model.Activity;
import com.pycsh.model.ActivityRecord;
import com.pycsh.model.DonateRecordTemp;
import com.pycsh.service.ActivityService;
import com.pycsh.service.DonateRecordProjectService;
import com.pycsh.service.DonateRecordService;
import com.pycsh.service.WeiXinUserService;
import com.pycsh.util.SerialNoUtil;
import com.tencent.WXPay;
import com.tencent.common.RandomStringGenerator;
import com.tencent.common.Signature;
import com.tencent.common.XMLParser;
import com.tencent.protocol.pay_protocol.PayReqData;
import com.weixin.common.Configuration;
import com.weixin.common.TokenFactory;
import com.weixin.common.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.xml.sax.SAXException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by dzf on 2015/7/17.
 */
@Controller
@RequestMapping("/wxpay")
public class WeiXinPayAction {
	
	@Autowired
	private DonateRecordProjectService drpService;
	
	@Autowired
	private WeiXinUserService userService;
	
	@Autowired
	private DonateRecordService donateService;
	
	@Autowired
	private ActivityService activityService;

    /**
     * 跳转到确定付款页面
     * @return
     */
    @RequestMapping("/toSelectPay")
    public String toSelectPay(ModelMap model, HttpServletRequest request, String state,String code){
        String ipAddr = Util.getIpAddr(request);
       // ipAddr= "104.251.224.184";
        Map<String, Object> webToken = TokenFactory.getWebToken(code);
        if(webToken != null){
            Date now = new Date();
            Date lostDate = new Date(now.getTime()+300000);
            String openid = (String) webToken.get("openid");
            String body = "慈善捐款"; // 商品描述
            String outTradeNo = SerialNoUtil.getSerialNo(SerialNoUtil.TYPE_WEIXIN); // 订单号,系统生成
            Long projectId = new Long(state.split("-")[1]);
            int totalFee = new Integer (state.split("-")[0] )*100;// 总金额，单位“分”
            Long actId = null;
            String name=null;
            String phone = null;
            String idcard=null;
            String exPhone = null;
            
            if(state.split("-").length>3){
            	
            	actId = new Long(state.split("-")[1]);
            	name= state.split("-")[3];
            	phone= state.split("-")[4];
            	idcard= "";
            	if(state.split("-").length>5){
            		idcard=state.split("-")[5];
            	}
            	exPhone= "";
            	if(state.split("-").length>6){
            		exPhone=state.split("-")[6];
            	}
            	Activity act = activityService.getActivity(actId);
            	projectId=act.getProjectId();
            }
            String notify_url = Configuration.Urls.HOSTS + "wxpay/callback.action"; // 支付结果回调地址
            PayReqData data = new PayReqData(body, outTradeNo, totalFee, ipAddr, notify_url, openid);
            try {
                String resp = WXPay.requestUnifiedPay(data);
               
                Map<String, Object> map = XMLParser.getMapFromXML(resp);
                if(map.get("return_code").equals(Configuration.RESP_CODE_SUCCEED)){
                    if(map.get("result_code").equals(Configuration.RESP_CODE_SUCCEED)){
                    	
                        String prepay_id = (String) map.get("prepay_id");
                        Map<String, Object> params = new HashMap<String, Object>();
                        params.put("appId", Configuration.APP_ID);
                        params.put("timeStamp", now.getTime() / 1000);
                        params.put("nonceStr", RandomStringGenerator.getRandomStringByLength(30));
                        params.put("package", "prepay_id=" + prepay_id);
                        params.put("signType", "MD5");
                        params.put("paySign", Signature.getSign(params));
                        params.put("packageStr", params.get("package"));
                        model.put("requestParams", params);
                        System.out.println(params);
                         
                        drpService.saveRecordTemp(new Long(state.split("-")[2]), outTradeNo, new Double(totalFee / 100 ), 2, projectId,actId, name, phone, idcard, exPhone);
                        return "wap/donate";
                    }else{

                    }
                }else{

                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    @SuppressWarnings("unused")
	@RequestMapping("/callback")
    public void callback(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> result = new HashMap<String, Object>(2);
        try {
            // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/xml");

            String xmlStr = Util.inputStreamToString(request.getInputStream());
            Map<String, Object> xmlMap = XMLParser.getMapFromXML(xmlStr);
            String sign = String.valueOf(xmlMap.remove("sign"));
            if(xmlMap.get("return_code").equals(Configuration.RESP_CODE_SUCCEED)
                    && xmlMap.get("trade_type").equals("JSAPI")
                    && xmlMap.get("appid").equals(Configuration.APP_ID)
                    && xmlMap.get("mch_id").equals(Configuration.MCH_ID)){
                int totalFee = Integer.parseInt(String.valueOf(xmlMap.get("total_fee")));
                Date endTime = Configuration.dateFormater.parse(String.valueOf(xmlMap.get("time_end")));
                String transactionId = String.valueOf(xmlMap.get("transaction_id")); //  微信单号
                String openid = String.valueOf(xmlMap.get("openid"));
                String outTradeNo =String.valueOf(xmlMap.get("out_trade_no"));
                Map<String,Object> rt=drpService.getRecordTempBySerialNo(outTradeNo);
                if(rt!=null&&rt.get("transactionId")==null){
                	rt.put("transactionId", transactionId);
                    rt.put("state", DonateRecordTemp.STATE_SUCCEED);
                    rt.put("endTime", endTime);
                    rt.put("money", new Double(totalFee/100));
                    drpService.updateRecordTemp(rt);
                    Long projectId =(Long)rt.get("projectId");
                    Long actId =(Long)rt.get("actId");
                    if(actId!=null){
	                	ActivityRecord ar= activityService.findActRecord(new Long((rt.get("id").toString())));
	                	ar.setStatus(1);
	                	activityService.updateActRecord(ar);
	                }
                    if(projectId!=null){
                    	
                    	drpService.saveRecord(projectId, (Long)rt.get("userId"), new Double(totalFee/100), 2,actId);
                    }else{
                    	donateService.saveRecord((Long)rt.get("userId"), new Double(totalFee/100), 2);
                    }
                    
                }
                
               response.getWriter().print(Configuration.RESP_CODE_SUCCEED);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
            if(result.size() > 0) result.clear();
            result.put("return_code", Configuration.RESP_CODE_FAIL);
            result.put("return_msg", "服务器错误");
        }
        try {
            response.getWriter().print(com.weixin.common.XMLParser.getXmlStrFromMap(result));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    
    @RequestMapping(value="callbackAJAX")
    public void callbackAJAX(HttpServletRequest request)throws Exception{
    	System.out.println(request.getParameterMap());
    }
}
