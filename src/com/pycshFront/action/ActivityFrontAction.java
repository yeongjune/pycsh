package com.pycshFront.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.authority.service.UserService;
import com.base.util.JSONUtil;
import com.base.vo.PageList;
import com.pycsh.model.Activity;
import com.pycsh.model.ActivitySign;
import com.pycsh.service.ActivityService;
import com.pycsh.service.ProjectService;
import com.pycsh.service.WeiXinUserService;
import com.site.service.ImageService;
import com.weixin.common.Configuration;

@Controller
@RequestMapping(value = "activityFront")
public class ActivityFrontAction {

	
	@Autowired
	private ActivityService service;
	
	@Autowired
	private WeiXinUserService userService;
	
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private ImageService imageService;
	
	
	
	@RequestMapping(value="loadActList")
	public void loadActList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,String name)throws Exception{
		PageList pageList = service.findActivityByPage(currentPage, pageSize, 1, 3,name);
		JSONUtil.printToHTML(response, pageList);
	}
	
	@RequestMapping(value="getActInfo")
	public void getActInfo(HttpServletRequest request,HttpServletResponse response,Long id)throws Exception{
		
		
		JSONUtil.printToHTML(response, service.getActivityByMap(id));
	}
	
	
	@RequestMapping(value="loadRecordStatistics")
	public void loadRecordStatistics(HttpServletRequest request,HttpServletResponse response,Long[] ids)throws Exception{
		List<Long> idList=new ArrayList<Long>();
		if(ids!=null){
			for(Long id:ids){
				idList.add(id);
			}
		}
		List<Map<String,Object>> list=service.findRecordStatistics(idList);
		JSONUtil.printToHTML(response, list);
	}
	
	@RequestMapping(value="loadRecordList")
	public void loadRecordList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Long id)throws Exception{
		
		PageList pageList = service.findRecordByPage(currentPage, pageSize,id);
		JSONUtil.printToHTML(response, pageList);
	}
	
	@RequestMapping(value="loadMyList")
	public void loadMyList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize)throws Exception{
		
		PageList pageList = service.findActivityByMyPage(currentPage, pageSize, userService.getSessionUserId(request.getSession()));
		JSONUtil.printToHTML(response, pageList);
		
	}
	
	
	@RequestMapping(value="loadRecordCount")
	public void loadRecordCount(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize)throws Exception{
		
		PageList pageList = service.findActivityByMyPage(currentPage, 999, userService.getSessionUserId(request.getSession()));
		JSONUtil.printToHTML(response, pageList.getList().size());
		
	}
	
	@RequestMapping(value="loadFile")
	public void loadFile(HttpServletRequest request,HttpServletResponse response,Integer id)throws Exception{
		List<Map<String,Object>> fileList = imageService.find(id, 3, null, null);
		JSONUtil.printToHTML(response, fileList);
		
	}
	
	@RequestMapping(value="saveActivitySign")
	public void saveActivitySign(HttpServletRequest request,HttpServletResponse response,Long actId,String name)throws Exception{
		if(name!=null&&!name.trim().equals("")){
			Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute(Configuration.SESSION_USER_KEY);
			if(user!=null&&user.get("openid")!=null){
				ActivitySign as=new ActivitySign();
				as.setActId(actId);
				as.setCreateTime(new Date());
				as.setName(name);
				as.setOpenId(user.get("openid").toString());
				as.setStatus(0);
				service.saveSign(as);
				response.getWriter().print(as.getId());
			}else{
				response.getWriter().print("notOpenId");
			}
		}else{
			response.getWriter().print("notName");
		}
		
		
	}
	
	@RequestMapping(value="toViewSign")
	public String toViewSign(HttpServletRequest request,HttpServletResponse response,Long id,ModelMap map)throws Exception{
		map.put("as", service.getSign(id));
		return "wap/actShear";
	}
}
