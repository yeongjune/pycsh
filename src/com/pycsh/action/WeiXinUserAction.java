package com.pycsh.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pycsh.service.SendMsgService;
import com.pycsh.service.WeiXinUserService;
import com.pycsh.util.CaptchaUitl;


@Controller
@RequestMapping(value="/weixinUser")
public class WeiXinUserAction {
	
	
	@Autowired
	private WeiXinUserService service;
	
	@Autowired
	private SendMsgService sendMsgService;
	
	/**
	 * 进入注册页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="toRegister")
	public String toRegister(HttpServletRequest request,String parameters,String url,ModelMap map) throws Exception{
		map.put("parameters", parameters);
		map.put("url", url);
		return "pycsh/weixinUser/register";
	}
	
	/**
	 * 发送验证码
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="sendCaptcha")
	public void sendCaptcha(HttpServletRequest request,HttpServletResponse response,String mobilesStr)throws Exception{
		Date captchaTime = (Date)request.getSession().getAttribute("captchaTime");
		String captcha ="";
		if(captchaTime==null||captchaTime.getTime()<(new Date().getTime()-60000)){
			captcha = CaptchaUitl.getCaptcha();
			request.getSession().setAttribute("captcha", captcha);
			request.getSession().setAttribute("captchaTime", new Date());
		}else{
			captcha = (String)request.getSession().getAttribute("captcha");
		}
		
		System.out.println(captcha);
		Map<String,Object> user=(Map<String,Object>)request.getSession().getAttribute("weixinUser");
		if(user!=null){
			mobilesStr=user.get("loginName").toString();
		}
		if(mobilesStr!=null&&Pattern.matches("\\d{11}", mobilesStr)){
			if(sendMsgService.getLastCount()>0){
				sendMsgService.sendMsg(mobilesStr, " 本次操作的验证码:"+captcha+"。请勿把验证码泄露给他人。如非本人操作，请忽略此短信。");
				sendMsgService.saveMsgRecord(mobilesStr, " 本次操作的验证码:"+captcha+"。请勿把验证码泄露给他人。如非本人操作，请忽略此短信。",1);
				response.getWriter().print("ok");
			}else{
				response.getWriter().print("notMsgCount");
			}
			
		}else{
			response.getWriter().print("notMobiles");
		}
	}

	/**
	 * 保存注册
	 * @param request
	 * @param loginName
	 * @param captcha
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="saveRegister")
	public String saveRegister(HttpServletRequest request,String loginName,String captcha,String parameters,String url,ModelMap map,String password)throws Exception{
		String sessionCaptcha = (String)request.getSession().getAttribute("captcha");
		Date captchaTime = (Date)request.getSession().getAttribute("captchaTime");
		map.put("url", url);
		map.put("parameters", parameters);
		if(captchaTime!=null&&captchaTime.getTime()>(new Date().getTime()-600000)&&captcha!=null&&captcha.equals(sessionCaptcha)){
			Map<String,Object> user = service.getUserByLoginName(loginName);
			if(user==null){
				user =	new HashMap<String, Object>();
				user.put("loginName", loginName);
				user.put("password", password);
				service.saveUser(user);
				
				request.getSession().setAttribute("weixinUser", service.getUserByLoginName(loginName));
				
				return "pycsh/weixinUser/loginFin";
			}else{
				map.put("tips", "该号码已注册!");
				return "pycsh/weixinUser/register";
			}
			
			
		}else{
			map.put("tips", "验证码不正确!");
			return "pycsh/weixinUser/register";
			
		}
		
	}
	
	/**
	 * 进入登录页
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="toLogin")
	public String toLogin(HttpServletRequest request,String parameters,String url,ModelMap map)throws Exception{
		map.put("parameters", parameters);
		map.put("url", url);
		return "pycsh/weixinUser/login";
	}
	
	/**
	 * 进入登录页
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="toLoginByMini")
	public String toLoginByMini(HttpServletRequest request,String parameters,String url,String toParam,ModelMap map)throws Exception{
		map.put("parameters", parameters);
		map.put("url", url);
		if(StringUtils.isNotBlank(toParam))
			map.put("toParam", toParam);
		return "pycsh/weixinUser/loginByMini";
	}
	/**
	 * 验证码登录
	 * @param request
	 * @param loginName
	 * @param captcha
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="loginByCaptchaMini")
	public String loginByCaptchaMini(HttpServletRequest request,String loginName,String captcha,ModelMap map,String url,String parameters)throws Exception{
		
		
		Map<String,Object> user=service.loginByCaptcha(loginName, captcha, request);
		map.put("url", url);
		map.put("parameters", parameters);
		if(user!=null){
			request.getSession().setAttribute("weixinUser", user);
			
			return "pycsh/weixinUser/loginFin";
		}else{
			map.put("tips", "验证码不正确!");
			return "pycsh/weixinUser/loginByMini";
		}
		
	}
	
	@RequestMapping(value="loginByPassword")
	public String loginByPassword(HttpServletRequest request,HttpServletResponse response,String toParam,String loginName,String password,ModelMap map,String url,String parameters)throws Exception{
		

		Map<String,Object> user=service.loginByPassword(loginName, password);
		map.put("url", url);
		map.put("parameters", parameters);
		if(StringUtils.isNotBlank(toParam))
			map.put("toParam", toParam);
		if(user!=null){
			request.getSession().setAttribute("weixinUser", user);
			
			return "pycsh/weixinUser/loginFin";
		}else{
			map.put("tips", "密码不正确!");
			return "pycsh/weixinUser/loginByMini";
		}
	}
	
	/**
	 * 验证码登录
	 * @param request
	 * @param loginName
	 * @param captcha
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="loginByCaptcha")
	public String loginByCaptcha(HttpServletRequest request,String loginName,String captcha,ModelMap map)throws Exception{
		
		
		Map<String,Object> user=service.loginByCaptcha(loginName, captcha, request);
		if(user!=null){
			request.getSession().setAttribute("weixinUser", user);
			return "redirect:/";
		}else{
			map.put("tips", "验证码不正确!");
			return "pycsh/weixinUser/login";
		}
		
	}
	
	@RequestMapping(value="toIndex")
	public String toIndex(HttpServletRequest request,HttpServletResponse response,ModelMap map)throws Exception{
		
		return "pycsh/index";
	}
	
	@RequestMapping(value="toPerfect")
	public String toPerfect(HttpServletRequest request,ModelMap map)throws Exception{
		Long userId =service.getSessionUserId(request.getSession());
		Map<String,Object> user = service.getUserById(userId);
		map.put("weixinUser", user);
		return "pycsh/weixinUser/perfect";
	}
	
	@RequestMapping(value="saveInfo")
	public void saveInfo(HttpServletRequest request,HttpServletResponse response,String name,String idCard,String email)throws Exception{
		Long userId =service.getSessionUserId(request.getSession());
		Map<String,Object> user = service.getUserById(userId);
		user.put("name", name);
		user.put("idCard", idCard);
		user.put("email", email);
		service.updateUser(user);
		request.getSession().setAttribute("weixinUser", user);
		response.getWriter().print("ok");
		
	}
	
	@RequestMapping(value="logout")
	public void logout(HttpServletRequest request,HttpServletResponse response)throws Exception{
		request.getSession().removeAttribute("weixinUser");
		response.getWriter().print("ok");
	}
	@RequestMapping(value="toUploadUserImg")
	public String toUploadUserImg(HttpServletRequest request,ModelMap map)throws Exception{
		Map<String,Object> user=service.getSessionUser(request.getSession());
		map.put("userImg", user.get("imgUrl"));//临时文件关联ID
		
		return "pycsh/weixinUser/uploadUserImg";
	}
	
	@RequestMapping(value="updateImg")
	public void updateImg(HttpServletRequest request,HttpServletResponse response,String smallPicUrl)throws Exception{
		Long userId =service.getSessionUserId(request.getSession());
		Map<String,Object> user = service.getUserById(userId);
		if(smallPicUrl!=null&&!smallPicUrl.trim().equals("")){
			
			user.put("imgUrl", smallPicUrl);
		}
		service.updateUser(user);
		request.getSession().setAttribute("weixinUser", user);
		response.getWriter().print("ok");
	}
	
	
	@RequestMapping(value="toFindPassword")
	public String toFindPassword(HttpServletRequest request,HttpServletResponse response,ModelMap map,String url,String parameters)throws Exception{
		map.put("url", url);
		map.put("parameters", parameters);
		return "pycsh/weixinUser/findPassword";
	}
	
	@RequestMapping(value="toResetPassword")
	public String toResetPassword(HttpServletRequest request,HttpServletResponse response,ModelMap map,String loginName,String captcha,String url,String parameters)throws Exception{
		
		String sessionCaptcha = (String)request.getSession().getAttribute("captcha");
		Date captchaTime = (Date)request.getSession().getAttribute("captchaTime");
		map.put("url", url);
		map.put("parameters", parameters);
		
		if(service.getUserByLoginName(loginName)==null){
			map.put("tips", "该用户不存在!");
			return "pycsh/weixinUser/findPassword";
		}
		if(captchaTime!=null&&captchaTime.getTime()>(new Date().getTime()-600000)&&captcha!=null&&captcha.equals(sessionCaptcha)){
			request.getSession().setAttribute("resetLoginName", loginName);
			return "pycsh/weixinUser/resetPassword";
		}else{
			map.put("tips", "验证码错误!");
			return "pycsh/weixinUser/findPassword";
		}
		
		
	}
	
	
	@RequestMapping(value="updateResetPassword")
	public String updateResetPassword(HttpServletRequest request,HttpServletResponse response,ModelMap map,String password,String url,String parameters)throws Exception{
		map.put("url", url);
		map.put("parameters", parameters);
		map.put("tips", "密码修改成功,请重新登录!");
		String loginName = (String)request.getSession().getAttribute("resetLoginName");
		Map<String,Object> user = service.getUserByLoginName(loginName);
		user.put("password", password);
		service.updateUser(user);
		return "pycsh/weixinUser/loginByMini";
	}
	
}
