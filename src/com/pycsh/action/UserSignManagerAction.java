package com.pycsh.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.authority.model.User;
import com.base.util.JSONUtil;
import com.base.vo.PageList;
import com.pycsh.model.CharityProject;
import com.pycsh.model.UserSign;
import com.pycsh.model.UserSignLog;
import com.pycsh.service.UserSignService;
import com.site.service.ImageService;


@Controller
@RequestMapping("userSignManager")
public class UserSignManagerAction {

	@Autowired
	private UserSignService service;

	
	
	
	
	@RequestMapping(value="toUserSignList")
	public String toUserSignList(HttpServletRequest request,HttpServletResponse response,ModelMap map)throws Exception{
		
		
		return "pycsh/userSign/index";
	}
	
	
	@RequestMapping(value="loadUserSignList")
	public void loadUserSignList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Integer status,String keyword)throws Exception{
		PageList<Map<String,Object>> pageList = service.findUserSignByPage(currentPage, pageSize, status,keyword);
		JSONUtil.printToHTML(response, pageList);
	}
	
	
	@RequestMapping(value="updateStatus")
	public void updateStatus(HttpServletRequest request,HttpServletResponse response,Long id,Integer status,String opinions)throws Exception{
		
		Map<String,Object> us=service.getUserSignMap(id);
		us.put("status", status);
		us.put("opinions", opinions);
		service.updateUserSign(us);
		UserSignLog usl= new UserSignLog();
		usl.setCheckUserId(User.getCurrentUserId(request));
		usl.setOpinions(opinions);
		usl.setStatus(status);
		usl.setUserId((Long)us.get("userId"));
		usl.setUserSignId((Long)us.get("id"));
		service.saveUserSignLog(usl);
		response.getWriter().print("ok");
	}
	
	@RequestMapping(value="getUserSign")
	public void getUserSign(HttpServletRequest request,HttpServletResponse response,Long id)throws Exception{
		Map<String,Object> us = service.getUserSignMap(id);
		JSONUtil.printToHTML(response, us);
	}
	
	@RequestMapping(value="toViewUserSign")
	public String toViewUserSign(HttpServletRequest request,HttpServletResponse response,Long id,ModelMap map)throws Exception{
		UserSign us = service.getUserSign(id);
		List<Map<String,Object>> imgList = service.findUserSignImg(us.getUserId());
		map.put("imgList", imgList);
		map.put("user", us);
		return "pycsh/userSign/view";
	}
	
	@RequestMapping(value="toCharityProjectManager")
	public String toCharityProjectManager(HttpServletRequest request,HttpServletResponse response,ModelMap map)throws Exception{
		
		return "pycsh/charityProject/index";
	}
	
	@RequestMapping(value="loadCharityProjectList")
	public void loadCharityProjectList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Integer status,String keyword)throws Exception{
		
		PageList<Map<String,Object>> pageList = service.findCharityProjectByPage(currentPage, pageSize, status, null, null, keyword);
		JSONUtil.printToHTML(response, pageList);
	}
	
	@RequestMapping(value="toViewCharityProject")
	public String toViewCharityProject(HttpServletRequest request,HttpServletResponse response,Long id,ModelMap map)throws Exception{
		map.put("project", service.getCharityProjectByMap(id));
		return "pycsh/charityProject/view";
	}
	
	@RequestMapping(value="updateCharityProjectStatus")
	public void updateCharityProjectStatus(HttpServletRequest request,HttpServletResponse response,Long id,Integer status,String opinions)throws Exception{
		CharityProject cp =service.getCharityProject(id);
		cp.setChecked(status);
		cp.setOpinions(opinions);
		if(status.equals(1)){
			cp.setStatus(3);
		}
		service.updateCharityProject(cp);
		response.getWriter().print("ok");
		
	}
}
