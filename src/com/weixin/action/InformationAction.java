package com.weixin.action;

import com.weixin.common.Configuration;
import com.weixin.common.InterfaceUtil;
import com.weixin.common.TokenFactory;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * 资讯入口
 * Created by dzf on 2015/7/14.
 */
@Controller
@RequestMapping("/weiXinInfo")
public class InformationAction {

    @RequestMapping("/user")
    public String getUser(ModelMap map, HttpSession session, String code){
        if(StringUtils.isNotEmpty(StringUtils.trim(code))){
            Map<String, Object> webToken = TokenFactory.getWebToken(code);
            String token = webToken.get("access_token").toString();
            String openid = webToken.get("openid").toString();
            session.setAttribute("userContent", InterfaceUtil.getUserInfo(token, openid));
        }
        return "weixin/info/index";
    }

    @RequestMapping("/toOrder")
    public String toOrder(HttpSession session){

        return "weixin/info/order";
    }

}
