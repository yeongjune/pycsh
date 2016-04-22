package com.pycshFront.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.util.JSONUtil;
import com.base.vo.PageList;
import com.pycsh.service.DonateRecordProjectService;
import com.pycsh.service.ProjectService;
import com.pycsh.service.WeiXinUserService;


@Controller
@RequestMapping("projectFront")
public class ProjecctFrontAction {

	
	@Autowired
	private ProjectService service;
	
	@Autowired
	private DonateRecordProjectService donateProjectService;
	
	@Autowired
	private WeiXinUserService userService;
	
	@RequestMapping(value="toIndex")
	public String toIndex()throws Exception{
		
		return "pycshFront/project/index";
		
	}
	
	
	@RequestMapping(value="loadList")
	public void loadList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,String name,String startTime,String endTime ,Integer status ,String type1,String type2)throws Exception{
		List<String> statusList=new ArrayList<String>();
		statusList.add("3,4,5");
		statusList.add("3");
		statusList.add("4");
		statusList.add("5");
		if(status==null){
			status=0;
		}
		PageList pageList = service.getPageList(currentPage, pageSize, name, startTime, endTime, statusList.get(status), type1, type2);
	
		JSONUtil.printToHTML(response, pageList);
	}
	
	
	@RequestMapping(value="getProject")
	public void getProject(HttpServletRequest request,HttpServletResponse response,Long id)throws Exception{
		Map<String,Object> project =service.find(id);
		JSONObject js= JSONObject.fromObject(project);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(js);
	}
	
	@RequestMapping(value="loadRecordStatistics")
	public void loadRecordStatistics(HttpServletRequest request,HttpServletResponse response,Long[] ids)throws Exception{
		List<Long> idList=new ArrayList<Long>();
		if(ids!=null){
			for(Long id:ids){
				idList.add(id);
			}
		}
		List<Map<String,Object>> list=donateProjectService.findRecordStatistics(idList);
		JSONUtil.printToHTML(response, list);
	}
	
	
	@RequestMapping(value="loadRecordList")
	public void loadRecordList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Long projectId)throws Exception{
		
		PageList pageList = donateProjectService.findRecordByPage(currentPage, pageSize,projectId);
		JSONUtil.printToHTML(response, pageList);
	}

	
	@RequestMapping(value="loadMyList")
	public void loadMyList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize)throws Exception{
		
		PageList pageList = service.findProjectByMyPage(currentPage, pageSize, userService.getSessionUserId(request.getSession()));
		JSONUtil.printToHTML(response, pageList);
		
	}
	
	@RequestMapping(value="loadMyRecord")
	public void loadMyRecord(HttpServletRequest request,HttpServletResponse response,Long projectId)throws Exception{
		
		List<Map<String,Object>> list=donateProjectService.findMyRecord(projectId,  userService.getSessionUserId(request.getSession()));
		JSONUtil.printToHTML(response, list);
	}
	
	@RequestMapping(value="loadRecordSum")
	public void loadRecordSum(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		List<Map<String,Object>> list=donateProjectService.findMyRecordByType(userService.getSessionUserId(request.getSession()));
		JSONUtil.printToHTML(response, list);
	}
	

	@RequestMapping(value="getSessionUserInfo")
	public void getSessionUserInfo(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Map<String,Object> user = userService.getUserById(userService.getSessionUserId(request.getSession()));
		JSONUtil.printToHTML(response, user);
	}
	
	
	@RequestMapping(value="loadRecordCount")
	public void loadRecordCount(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<Map<String,Object>> list=donateProjectService.findMyRecord(null,  userService.getSessionUserId(request.getSession()));
		JSONUtil.printToHTML(response, list.size());
	}

	
}
