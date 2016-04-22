package com.alipay.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipayNotify;
import com.alipay.util.AlipaySubmit;
import com.pycsh.model.Activity;
import com.pycsh.model.ActivityRecord;
import com.pycsh.model.DonateRecordTemp;
import com.pycsh.service.ActivityService;
import com.pycsh.service.DonateRecordProjectService;
import com.pycsh.service.DonateRecordService;
import com.pycsh.service.ProjectService;
import com.pycsh.service.WeiXinUserService;
import com.pycsh.util.SerialNoUtil;
import com.weixin.common.Configuration;



@Controller
@RequestMapping("alipay")
public class alipayAction {
	

	@Autowired
	private DonateRecordProjectService drpService;
	
	@Autowired
	private WeiXinUserService userService;
	
	@Autowired
	private DonateRecordService donateService;
	
	@Autowired
	private ProjectService projectService;
	

	@Autowired
	private ActivityService activityService;
	
	
	@RequestMapping(value="toAlipay")
	public String toAlipay(HttpServletRequest request,HttpServletResponse response,ModelMap map)throws Exception{
		
		return "alipay/index";
	}
	
	/**
	 * 创建支付请求
	 * @param request
	 * @param response
	 * @param projectId 慈善项目Id
	 * @param projectName 慈善项目名称
	 * @param total_fee 付款金额
	 * @throws Exception
	 */
	@RequestMapping(value="addPay")
	public void addPay(HttpServletRequest request,HttpServletResponse response,String total_fee,Long projectId,Long actId,String name,String phone,String idcard,String exPhone)throws Exception{
		//支付类型
				String payment_type = "1";
				//必填，不能修改
				//服务器异步通知页面路径
				String notify_url = Configuration.Urls.HOSTS+"alipay/alipayNotify.action";
				//需http://格式的完整路径，不能加?id=123这类自定义参数

				//页面跳转同步通知页面路径
				String return_url = Configuration.Urls.HOSTS+"alipay/alipayReturn.action";
				//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

				//商户订单号
				String out_trade_no = SerialNoUtil.getSerialNo(SerialNoUtil.TYPE_ALIPAY);
				
				
				if(actId!=null){
					Activity act = activityService.getActivity(actId);
					projectId=act.getProjectId();
				}
				Map<String,Object> pro=projectService.find(projectId);
				String projectName ="";
				if(pro!=null&&pro.get("name")!=null){
					projectName = pro.get("name").toString();
				}
				
				
				//订单名称
				String subject = "慈善捐赠";
				
				//商品描述
				String body = "慈善捐赠";
				
				if(!projectName.equals("")){
					subject = projectName+"项目 慈善捐赠";
					body = projectName+"项目 慈善捐赠";
				}
				
				//商品展示地址
				String show_url =  Configuration.Urls.HOSTS+"go-project_view.html?id="+projectId;
				//需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

				//防钓鱼时间戳
				String anti_phishing_key = "";
				//若要使用请调用类文件submit中的query_timestamp函数

				//客户端的IP地址
				String exter_invoke_ip = "58.63.245.206";
				//非局域网的外网IP地址，如：221.0.0.1
				
				
				
				drpService.saveRecordTemp(userService.getSessionUserId(request.getSession()), out_trade_no, new Double(total_fee), 1, projectId,actId, name, phone, idcard, exPhone);
				//////////////////////////////////////////////////////////////////////////////////
				
				//把请求参数打包成数组
				Map<String, String> sParaTemp = new HashMap<String, String>();
				sParaTemp.put("service", "create_donate_trade_p");
		        sParaTemp.put("partner", AlipayConfig.partner);
		        sParaTemp.put("seller_email", AlipayConfig.seller_email);
		        sParaTemp.put("_input_charset", AlipayConfig.input_charset);
				sParaTemp.put("payment_type", payment_type);
				sParaTemp.put("notify_url", notify_url);
				sParaTemp.put("return_url", return_url);
				sParaTemp.put("out_trade_no", out_trade_no);
				sParaTemp.put("subject", subject);
				//total_fee="0.01";
				sParaTemp.put("total_fee", total_fee);
				sParaTemp.put("body", body);
				sParaTemp.put("show_url", show_url);
				sParaTemp.put("anti_phishing_key", anti_phishing_key);
				sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
				
				//建立请求
				String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().println(sHtmlText);
		
	
	}
	
	/**
	 * 支付后回调请求
	 * @param request
	 * @param response
	 * @param out_trade_no 流水号
	 * @param trade_no 支付宝交易号
	 * @param trade_status 支付状态
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="alipayReturn")
	public String alipayReturn(HttpServletRequest request,HttpServletResponse response,String out_trade_no,String trade_no,String trade_status)throws Exception{
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}
		
		
		//计算得出通知验证结果
		boolean verify_result = AlipayNotify.verify(params);
		if(verify_result){
			System.out.println("支付成功");
			Map<String,Object> rt=drpService.getRecordTempBySerialNo(out_trade_no);
            if(rt!=null&&rt.get("transactionId")==null){
            	rt.put("transactionId", trade_no);
                rt.put("state", DonateRecordTemp.STATE_SUCCEED);
                rt.put("endTime", new Date());
                //rt.put("money", new Double(totalFee/100));
                drpService.updateRecordTemp(rt);
                Long projectId =(Long)rt.get("projectId");
                Long actId = (Long)rt.get("actId");
                if(actId!=null){
                	ActivityRecord ar= activityService.findActRecord(new Long((rt.get("id").toString())));
                	ar.setStatus(1);
                	activityService.updateActRecord(ar);
                }
                if(projectId!=null){
                	
                	drpService.saveRecord(projectId, (Long)rt.get("userId"), (Double)rt.get("money"), 1,actId);
                }else{
                	donateService.saveRecord((Long)rt.get("userId"), (Double)rt.get("money"), 1);
                }
               
                
            }
            return "alipay/paySuccess";
		}else{
			System.out.println("支付失败");
			return "alipay/payFail";
		}
	}
	
	/**
	 * 支付宝异步回调请求
	 * @param request
	 * @param response
	 * @param out_trade_no 流水号
	 * @param trade_no 支付宝交易号
	 * @param trade_status 支付状态
	 * @throws Exception
	 */
	@RequestMapping(value="alipayNotify")
	public void alipayNotify(HttpServletRequest request,HttpServletResponse response,String out_trade_no,String trade_no,String trade_status)throws Exception{
		
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}


		if(AlipayNotify.verify(params)){//验证成功
			//////////////////////////////////////////////////////////////////////////////////////////
			//请在这里加上商户的业务逻辑程序代码

			//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
			Map<String,Object> rt=drpService.getRecordTempBySerialNo(out_trade_no);
			
			 if(rt!=null&&rt.get("transactionId")==null){
				 rt.put("transactionId", trade_no);
	                rt.put("state", DonateRecordTemp.STATE_SUCCEED);
	                rt.put("endTime", new Date());
	                //rt.put("money", new Double(totalFee/100));
	                drpService.updateRecordTemp(rt);
	                Long projectId =(Long)rt.get("projectId");
	                Long actId = (Long)rt.get("actId");
	                if(actId!=null){
	                	ActivityRecord ar= activityService.findActRecord(new Long((rt.get("id").toString())));
	                	ar.setStatus(1);
	                	activityService.updateActRecord(ar);
	                }
	                if(projectId!=null){
	                	
	                	drpService.saveRecord(projectId, (Long)rt.get("userId"), (Double)rt.get("money"), 1,actId);
	                }else{
	                	donateService.saveRecord((Long)rt.get("userId"), (Double)rt.get("money"), 1);
	                }
			}else{
				
			}

			//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
				
			response.getWriter().println("success");	//请不要修改或删除

			//////////////////////////////////////////////////////////////////////////////////////////
		}else{//验证失败
			response.getWriter().println("fail");
		}
		
	}

}
