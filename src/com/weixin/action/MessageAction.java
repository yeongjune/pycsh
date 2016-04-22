package com.weixin.action;

import com.base.util.JSONUtil;
import com.site.service.ColumnService;
import com.weixin.common.*;
import com.weixin.event.ClickEvent;

import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dzf on 2015/7/10.
 */
@Controller("WeiXinMessageAction")
@RequestMapping("/weiXinMsg")
public class MessageAction {

    private static final String TOKEN = "panyuqucishanhui";
    
    @Autowired
    private ColumnService columnService;

    @RequestMapping(value = "/into", method = RequestMethod.GET)
    public void into(HttpServletRequest request, HttpServletResponse response){
        Map<String, String[]> map = request.getParameterMap();
        if(map.containsKey("signature") && map.containsKey("timestamp")
                && map.containsKey("nonce") && map.containsKey("echostr")){
            String signature = request.getParameter("signature");
            String echostr = request.getParameter("echostr");
            Map<String, Object> checkMap = new HashMap<String, Object>();
            checkMap.put("token", TOKEN);
            checkMap.put("timestamp", request.getParameter("timestamp"));
            checkMap.put("nonce", request.getParameter("nonce"));
            try {
                String sign = Signature.getSign(checkMap);
                if(sign.equals(signature)){
                    JSONUtil.print(response, echostr);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return;
    }

    @RequestMapping(value = "/into", method = RequestMethod.POST)
    public void intoPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/xml");

        // 微信加密签名
        String msg_signature = request.getParameter("msg_signature");
        // 时间戳
        String timestamp = request.getParameter("timestamp");
        // 随机数
        String nonce = request.getParameter("nonce");

        //从请求中读取整个post数据
        String xmlStr = Util.inputStreamToString(request.getInputStream());
        try {
            Map<String, Object> xmlMap = XMLParser.getMapFromXML(xmlStr);
            if(xmlMap.get("MsgType").equals("event")){// 事件类型
                if(xmlMap.get("Event").equals("CLICK")){//点击事件
                    JSONUtil.print(response, ClickEvent.push(xmlMap));
                    return;
                }else if(xmlMap.get("Event").equals("subscribe")){
                	
                	String str = columnService.getWelcomeText();
                	
                	
                	 String myId = (String) xmlMap.get("ToUserName");
                     String userId = (String) xmlMap.get("FromUserName");
            
                     JSONUtil.print(response, MessageFactory.text(userId, myId, str));
                     return;
                }
            }else if(xmlMap.get("MsgType").equals("text")){
                String myId = (String) xmlMap.get("ToUserName");
                String userId = (String) xmlMap.get("FromUserName");
                StringBuffer sb = new StringBuffer("<a");
                sb.append(" href=\"");
                sb.append(Util.getLoginUrl(Configuration.Urls.HOSTS + "wxUser/toIndex.action"));
                sb.append("\">跳转页面</a>");
                JSONUtil.print(response, MessageFactory.text(userId, myId, sb.toString()));
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return;
    }

}
