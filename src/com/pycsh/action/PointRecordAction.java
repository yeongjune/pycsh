package com.pycsh.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.base.util.JSONUtil;
import com.base.vo.PageList;
import com.pycsh.service.PointRecordService;
import com.pycsh.service.UserSignService;
import com.pycsh.service.WeiXinUserService;

@Controller
@RequestMapping(value="pointRecord")
public class PointRecordAction {
	
	@Autowired
	private UserSignService service;
	
	@Autowired
	private WeiXinUserService userService;
	
	@Autowired
	private PointRecordService pointRecordService;
	/**
	 * 
	 * @param request
	 * @param response
	 * @param currentPage
	 * @param pageSize
	 * @param name
	 * @param type
	 * @throws Exception
	 * @desc 获取大赛项目
	 */
	@RequestMapping(value="loadCharityProjectList")
	public void loadCharityProjectList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,String name,Integer type)throws Exception{
		
		PageList<Map<String,Object>> pageList =service.findCharityProjectByPage(currentPage, pageSize, name, type);
		List<Map<String,Object>> list=(List<Map<String, Object>>) pageList.getList();
		for(Map<String,Object> data:list){
			long id=(Long)data.get("id");
			data.put("pointCount",pointRecordService.getPointCount(id));//根据项目id获取已获票数
		}
		JSONUtil.printToHTML(response, pageList);
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @param projectId
	 * @throws Exception
	 * @desc 保存投票
	 */
	@RequestMapping(value="save",method=RequestMethod.POST)
	public void save(HttpServletRequest request,HttpServletResponse response,
			@RequestParam(value="pid",required=true)long projectId)throws Exception{
		Long userId =userService.getSessionUserId(request.getSession());
		if(userId!=null){
			if(pointRecordService.getBolCount(projectId, userId)>0){
				response.getWriter().print("already");//已经投过
			}else{
				if(pointRecordService.addPointRecord(projectId, userId))
					response.getWriter().print("success");//投票成功
			}
		}else{
			response.getWriter().print("noLogin");//未登陆
		}
	}
	
}
