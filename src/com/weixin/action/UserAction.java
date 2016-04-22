package com.weixin.action;

import com.base.util.CryptUtil;
import com.base.util.JSONUtil;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.pycsh.service.ActivityService;
import com.pycsh.service.WeiXinUserService;
import com.site.service.ArticleService;
import com.site.service.ColumnService;
import com.site.vo.ArticleSearchVo;
import com.weixin.common.Configuration;
import com.weixin.common.InterfaceUtil;
import com.weixin.common.TokenFactory;
import com.weixin.common.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Created by dzf on 2015/7/16.
 */
@Controller("wxUserAction")
@RequestMapping("/wxUser")
public class UserAction {

    @Autowired
    private WeiXinUserService userService;
    
    @Autowired
    private ArticleService articleService;

    @Autowired
    private ColumnService columnService;
    
    @Autowired
    private ActivityService activityService;
    
    /**
     * 跳转绑定手机
     * @param code 微信接口调用传入的参数
     */
    @RequestMapping("/toBindPhone")
    public String toBindPhone(HttpSession session,ModelMap map)throws Exception{
		Map<String, Object> user = (Map<String, Object>) session.getAttribute(Configuration.SESSION_USER_KEY);
//		Map<String, Object> wxUser =(Map<String, Object>)user.get(Configuration.SESSION_USER_INFO_KEY);
//		System.out.println(user);
    	map.put("wxUser", user);
        return "wap/registered";
    }

    @RequestMapping(value="toIndex")
    public String toIndex(HttpServletRequest request,ModelMap map)throws Exception{

    	map.put("loginUrl", Util.getLoginUrl(Configuration.Urls.HOSTS+"wxUser/toBindPhone.action"));
    	return "wap/index";
    }

    /**
     * 手机微信端活动页面
     * @param request
     * @param map
     * @return
     * @throws Exception
     */
    @RequestMapping(value="toActivityIndex")
    public String toActivityIndex(HttpServletRequest request,ModelMap map)throws Exception{
        map.put("loginUrl", Util.getLoginUrl(Configuration.Urls.HOSTS+"wxUser/toBindPhone.action"));
        return "wap/activityIndex";
    }
    
    /**'
     * 绑定手机号码
     * @param phone 手机号码
     * @param validateCode 校验码
     */
    @RequestMapping("/bindPhone")
    public void bindPhone(HttpServletRequest request,HttpServletResponse response,HttpSession session, String phone, String validateCode, String name,String password)throws Exception{
    	String sCode = (String)request.getSession().getAttribute("captcha");
		Date captchaTime = (Date)request.getSession().getAttribute("captchaTime");
		password=CryptUtil.MD5encrypt(password);
		if(captchaTime!=null&&captchaTime.getTime()>(new Date().getTime()-600000)&&validateCode!=null&&validateCode.equals(sCode)){
			   Map<String, Object> user = (Map<String, Object>) session.getAttribute(Configuration.SESSION_USER_KEY);
		        if(user != null && Pattern.matches("\\d{11}", phone)){
		            String openid = (String) user.get("openid");
		            Map<String, Object> userInfo = userService.getUserByPhoneOrOpenid(phone, openid);
		            if(userInfo == null){ //新用户
		                Map<String, Object> saveUser = new HashMap<String, Object>(3);
		                saveUser.put("wxOpenId", openid);
		                saveUser.put("loginName", phone);
		                saveUser.put("password", password);
		                saveUser.put("name", name);
		                saveUser.put("imgUrl", user.get("headimgurl"));
		                userService.saveUser(saveUser);
		                user.put(Configuration.SESSION_USER_INFO_KEY, saveUser);
		                session.setAttribute(Configuration.SESSION_USER_KEY, user);
		                session.setAttribute("weixinUser", saveUser);
		                
		                session.removeAttribute("callBackUrl");
		                response.getWriter().print("ok");
		            }else{
		                Long id = (Long) userInfo.get("id");
		                String uOpenid = (String) userInfo.get("wxOpenId");
		                String uPhone = (String) userInfo.get("loginName");
		                Map<String, Object> params = new HashMap<String, Object>(2);
		                if(StringUtil.isEmpty(uOpenid)){// PC网站已经注册用户
		                    params.put("id", id);
		                    params.put("wxOpenId", openid);
		                    params.put("name", name);
		                    params.put("password", password);
		                    params.put("imgUrl", user.get("headimgurl"));
		                    int change = userService.updateUser(params);
		                    user.put(Configuration.SESSION_USER_INFO_KEY, userService.getUserByPhoneOrOpenid(phone, openid));
		                    session.setAttribute(Configuration.SESSION_USER_KEY, user);
		                    session.setAttribute("weixinUser", user.get(Configuration.SESSION_USER_INFO_KEY));
			                
		                    session.removeAttribute("callBackUrl");
		                    response.getWriter().print("ok");
		                }else if(StringUtil.isEmpty(uPhone)){// 微信已注册用户
		                    params.put("id", id);
		                    params.put("loginName", phone);
		                    params.put("name", name);
		                    params.put("password", password);
		                    params.put("imgUrl", user.get("headimgurl"));
		                    int change = userService.updateUser(params);
		                    user.put(Configuration.SESSION_USER_INFO_KEY, userService.getUserByPhoneOrOpenid(phone, openid));
		                    session.setAttribute(Configuration.SESSION_USER_KEY, user);
		                    session.setAttribute("weixinUser", user.get(Configuration.SESSION_USER_INFO_KEY));
			                
		                    session.removeAttribute("callBackUrl");
		                    response.getWriter().print("ok");
		                }else{// 注册且已经绑定
		                	 response.getWriter().print("isRes");
		                }
		            }
		        }else{
		        	response.getWriter().print("userError");
		        }
			
		}else{
			response.getWriter().print("captchaError");
		}
        
     
    }

    /**
     * 更新系统用户资料
     * @param session
     */
    @RequestMapping("/updateInfo")
    public void updateInfo(HttpSession session,String name,Integer gender,String liveAddress , String email,HttpServletResponse response)throws Exception{
       Map<String,Object> user =userService.getUserById(userService.getSessionUserId(session));
       if(name!=null&&!name.trim().equals("")){
    	   user.put("name", name);
       }
       if(gender!=null){
    	   user.put("gender", gender);
       }
       if(liveAddress!=null&&!liveAddress.trim().equals("")){
    	   user.put("liveAddress", liveAddress);
       }
       if(email!=null&&!email.trim().equals("")){
    	   user.put("email", email);
       }
       userService.updateUser(user);
       response.getWriter().print("ok");
    }

    /**
     * 跳转“我的捐助”页面
     * @return
     */
    @RequestMapping("/toMyDonate")
    public String toMyDonate(HttpSession session,ModelMap map){
            //Map<String, Object> user = (Map<String, Object>) session.getAttribute(Configuration.SESSION_USER_KEY);
            //Map<String,Object> userInfo = (Map<String, Object>) user.get(Configuration.SESSION_USER_INFO_KEY);
	        //map.put("user", user);
	        map.put("userInfo", userService.getSessionUser(session));
	        return "wap/myDonate";
    }

    /**
     * 跳转“我的捐助”页面
     * @return
     */
    @RequestMapping("/toMyActivity")
    public String toMyActivity(HttpSession session,ModelMap map){
        map.put("userInfo", userService.getSessionUser(session));
        return "wap/myActivity";
    }
    
    @RequestMapping(value="toUserInfo")
    public String toUserInfo(HttpServletRequest request,HttpServletResponse response,ModelMap map)throws Exception{
    	map.put("userInfo", userService.getUserById(userService.getSessionUserId(request.getSession())));
    	return "wap/userInfo";
    }
    
    @RequestMapping(value="getCodeUrl")
    public void getCodeUrl(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	response.getWriter().print(Util.getLoginUrl(Configuration.Urls.HOSTS+"wxpay/toSelectPay.action"));
    	
    }
    
    @RequestMapping(value="loadNewsList")
    public void loadNewsList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Integer type)throws Exception{
    	ArticleSearchVo searchVo =new ArticleSearchVo();

    	searchVo.setColumnId(type);
    	PageList pageList =articleService.findArticlePageList(currentPage, pageSize, searchVo, false);
    	JSONUtil.printToHTML(response, pageList);
    }
    
    @RequestMapping(value="loadNews")
    public void loadNews(HttpServletRequest request,HttpServletResponse response,Integer id)throws Exception{
    	JSONUtil.printToHTML(response, articleService.get(id));
    	
    }
    
    @RequestMapping(value="updateImg")
    public void updateImg(HttpServletRequest request,HttpSession session,HttpServletResponse response)throws Exception{
    	Map<String, Object> wxUser = (Map<String, Object>) session.getAttribute(Configuration.SESSION_USER_KEY);
    	Map<String,Object> user =userService.getUserById(userService.getSessionUserId(session));
    	user.put("imgUrl", wxUser.get("headimgurl"));
    	userService.updateUser(user);
    	request.getSession().setAttribute("weixinUser", user);
        response.getWriter().print("ok");
    	
    }
    @RequestMapping(value="loadIndex")
    public void loadIndex(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	
    	ArticleSearchVo searchVo =new ArticleSearchVo();

    	searchVo.setColumnId(2370);
    	PageList pageList =articleService.findArticlePageList(1, 5, searchVo, false);
    	JSONUtil.printToHTML(response, pageList.getList());
    }
    
    
    /**
     * 手机微信端活动查看页面
     * @param request
     * @param map
     * @return
     * @throws Exception
     */
    @RequestMapping(value="toActivityView/{actId}")
    public void toActivityView(HttpServletRequest request,HttpServletResponse response,ModelMap map,@PathVariable("actId") Long id)throws Exception{
    	System.out.println("转跳中 ~~~~id:"+id);
    	request.getRequestDispatcher("/wxUser/viewActivity.action?id="+id).forward(request, response);
    }
    
    
    @RequestMapping(value="viewActivity")
    public String viewActivity(HttpServletResponse response,HttpServletRequest request,Long id)throws Exception{
    	System.out.println("转跳成功 ~~~~id:"+id);
    	return "redirect:/go-activity_view_wap.html?id="+id;
    }

    @RequestMapping(value="toActivitySign/{actId}")
    public String toActivitySign(HttpServletRequest request,HttpServletResponse response,ModelMap map,@PathVariable("actId") Long id)throws Exception{
    	
    	map.put("act", activityService.getActivity(id));
    	map.put("actId", id);
    	//Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute(Configuration.SESSION_USER_KEY);
    	
    	return "wap/actSign";
    }
    
    
}
