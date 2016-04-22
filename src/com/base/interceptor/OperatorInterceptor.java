package com.base.interceptor;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.base.util.StringUtil;
import com.pycsh.service.WeiXinUserService;
import com.weixin.common.Configuration;
import com.weixin.common.InterfaceUtil;
import com.weixin.common.TokenFactory;
import com.weixin.common.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.authority.model.User;
import com.authority.service.UserService;
import com.base.config.Init;

public class OperatorInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private WeiXinUserService weiXinUserService;

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

        String actionName = request.getRequestURI().replace(request.getContextPath(), "");
        actionName = actionName.replaceAll("/+", "/");
		if(isExcludeUrl(request, actionName)){
			return true;
		}else{
            if(isWeiXinUrl(request, actionName)){// 微信
                Map<String, Object> user = (Map<String, Object>)request.getSession().getAttribute(Configuration.SESSION_USER_KEY);
                if(isWeiXinLoginUrl(actionName) && user != null && user.get("nickname") == null){
                    request.getSession().removeAttribute(Configuration.SESSION_USER_KEY);
                    user = null;
                }
                if(user == null){
                    String code = request.getParameter("code");
                    if(StringUtil.isEmpty(code)){
                        String scope = "snsapi_base";
                        if(isWeiXinLoginUrl(actionName))
                            scope = "snsapi_userinfo";
                        response.getWriter().write("<script>window.location.href='"
                                + Util.getLoginUrl(
                                (Configuration.Urls.HOSTS.charAt(Configuration.Urls.HOSTS.length() - 1) == '/' ?
                                        ( Configuration.Urls.HOSTS.substring(0, Configuration.Urls.HOSTS.length() -1) )
                                        : Configuration.Urls.HOSTS)
                                + (actionName.charAt(0) == '/' ? actionName : ("/" + actionName))
                                , scope)
                                +"';</script>");
                        return false;
                    }else{
                        Map<String, Object> webToken = user = TokenFactory.getWebToken(code);
                        String scope = (String) webToken.get("scope");
                        if("snsapi_base".equals(scope)){
                            request.getSession().setAttribute(Configuration.SESSION_USER_KEY, webToken);
                        }else if("snsapi_userinfo".equals(scope)){
                            user = InterfaceUtil.getUserInfo(webToken);
                            request.getSession().setAttribute(Configuration.SESSION_USER_KEY, user);
                        }
                    }
                }
                if(isWebUrl(actionName)) return true;
                if(user.get(Configuration.SESSION_USER_INFO_KEY) == null){
                    String openid = (String) user.get("openid");
                    Map<String, Object> userinfo = weiXinUserService.getUserByOpenid(openid);
                    if(userinfo == null && !actionName.startsWith(Configuration.Urls.BIND_PHONE_ACTION)){
                        request.getSession().removeAttribute(Configuration.SESSION_USER_KEY);
                        request.getSession().setAttribute("callBackUrl", actionName);;
                        
                        response.getWriter().write("<script>window.location.href='"+ Configuration.Urls.WEI_XIN_BIND_PHONE +"';</script>");
                        return false;
                    }
                    user.put(Configuration.SESSION_USER_INFO_KEY, userinfo);
                    request.getSession().setAttribute("weixinUser", userinfo);
                    return true;
                }
                return true;
            }else if(actionName!=null && isAuthorityUrl(actionName)){
				if(managerLogin(request, response)){
					if(managerAuthority(request, response)){
						return true;
					}else{
						return false;
					}
				}else{
					if(actionName.startsWith("/lottery")){
						response.getWriter().write("<script>window.location.href='/lottery/login/index.action';</script>");
					}else{
						response.getWriter().write("<script>window.location.href='/login/index.action';</script>");
					}
					return false;
				}
			}else{
				return false;
			}
		}
	}

	/**
	 * 判断是否后台管理链接
	 * @param actionName
	 * @return
	 */
	private boolean isAuthorityUrl(String actionName) {
		return true;
//		LinkedHashMap<String, Object> excludeUrlMap = Init.get("authorityUrl");
//		if(excludeUrlMap==null || excludeUrlMap.isEmpty())return false;
//		for (String key : excludeUrlMap.keySet()) {
//			@SuppressWarnings("unchecked")
//			LinkedHashMap<String, Object> map = (LinkedHashMap<String, Object>) excludeUrlMap.get(key);
//			if(map!=null){
//				if(actionName.contains(map.get("value").toString()))return true;
//			}
//		}
//		return false;
	}

	/**
	 * 判断是否已经登录前台
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean memberLogin(HttpServletRequest request) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("member");
		return user!=null && !user.isEmpty();
	}

	/**
	 * 判断是否已经登录后台
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private boolean managerLogin(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute(Init.AUTHORITY_USER);
		if(user!=null && !user.isEmpty()){
			return true;
		}else{
			int i = 0;
			Map<String, Object> cookie = User.cookie(request);
			if(cookie!=null && !cookie.isEmpty()){
				UserService userService = com.base.util.ContextAware.getService(UserService.class);
				user = userService.getUserByIdAndPassword((Integer)cookie.get("organizationId"), (String)cookie.get("account"), (String)cookie.get("password"));
				i = User.login(request, user);
			}
			return i>0;
		}
	}
	/**
	 * 判断是否有访问权限
	 * @param request
	 * @param response
	 * @return
	 */
	private boolean managerAuthority(HttpServletRequest request, HttpServletResponse response) {
		@SuppressWarnings("unchecked")
		Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute(Init.AUTHORITY_USER);
		if(user!=null && !user.isEmpty()){
			if(user.get("account").equals("admin"))return true;
			String actionName = request.getRequestURI().replace(request.getContextPath(), "");
			actionName = actionName.replaceAll("\\+", "/");
			actionName = actionName.replaceAll("/+", "/");
			actionName = actionName.substring(1, actionName.lastIndexOf("."));
			if(actionName.equals(Init.SYSTEM_INDEX_URL))return true;
			Object obj = request.getSession().getServletContext().getAttribute(Init.APPLICATION_URL_KEY);
			if(obj!=null && obj instanceof Map){
				@SuppressWarnings("unchecked")
				Map<Object, Map<String, Object>> urlsMap = (Map<Object, Map<String, Object>>) obj;
				if(urlsMap.get(actionName)!=null && urlsMap.get(actionName).get("common")!=null && urlsMap.get(actionName).get("common").equals(1))return true;
				@SuppressWarnings("unchecked")
				Set<String> urlSet = (Set<String>) user.get("urlSet");
				if(urlSet==null || urlSet.isEmpty())return false;
				if(urlSet.contains(actionName))return true;
			}else{
				User.logout(request, response);
			}
			return false;
		}
		return false;
	}

	/**
	 * 判断是否是开放的访问地址
	 * @param actionName
	 * @return
	 */
	private boolean isExcludeUrl(HttpServletRequest request, String actionName){
		if(actionName.contains("/authorityLogin/"))return true;
		if(actionName.contains("/login/"))return true;
		if("/".equals(actionName)) return true;
		LinkedHashMap<String, Object> excludeUrlMap = Init.get("excludeUrl");
		if(excludeUrlMap!=null && !excludeUrlMap.isEmpty()) {
			for (String key : excludeUrlMap.keySet()) {
				@SuppressWarnings("unchecked")
				LinkedHashMap<String, Object> map = (LinkedHashMap<String, Object>) excludeUrlMap.get(key);
				if(map!=null){
					if(actionName.contains(map.get("value").toString()))return true;
				}
			}
		}
		Object obj = request.getSession().getServletContext().getAttribute(Init.APPLICATION_URL_KEY);
		if(obj!=null && obj instanceof Map){
			@SuppressWarnings("unchecked")
			Map<Object, Map<String, Object>> urlsMap = (Map<Object, Map<String, Object>>) obj;
			String key = request.getRequestURI().replace(request.getContextPath(), "");
			key = key.replaceAll("\\+", "/");
			key = key.replaceAll("/+", "/");
			key = key.substring(1, key.lastIndexOf("."));
			if(urlsMap.get(key)!=null && urlsMap.get(key).get("isPublic")!=null) {
				if (urlsMap.get(key).get("isPublic").equals(1)) {
					return true;
				}
			}
		}
		return false;
	}

    /**
     * 微信请求的拦截
     * @param request
     * @param actionName
     * @return
     */
    private boolean isWeiXinUrl(HttpServletRequest request, String actionName){
        return isExcludeUrl(actionName, "weiXinUrl");
    }

    private boolean isWeiXinLoginUrl(String actionName){
        return isExcludeUrl(actionName, "weiXinLoginUrl");
    }

    private boolean isWebUrl(String actionName){
        return isExcludeUrl(actionName, "weiXinWebUrl");
    }

    private boolean isExcludeUrl(String actionName, String keyName){
        if(actionName == null) return false;
        LinkedHashMap<String, Object> excludeUrlMap = Init.get(keyName);
        if(excludeUrlMap==null || excludeUrlMap.isEmpty())return false;
        for (String key : excludeUrlMap.keySet()) {
            @SuppressWarnings("unchecked")
            LinkedHashMap<String, Object> map = (LinkedHashMap<String, Object>) excludeUrlMap.get(key);
            if(map!=null && map.get("value") != null){
                if(actionName.startsWith(map.get("value").toString()))return true;
            }
        }
        return false;
    }
}
