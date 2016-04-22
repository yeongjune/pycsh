package com.pycshFront.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import sun.print.resources.serviceui;

import com.base.util.JSONUtil;
import com.pycsh.dao.DonateProjectDao;
import com.pycsh.model.Activity;
import com.pycsh.service.ActivityService;
import com.pycsh.service.DonateRecordProjectService;
import com.pycsh.service.DonateRecordService;
import com.pycsh.service.ProjectService;
import com.pycsh.service.WeiXinUserService;
import com.pycsh.util.SerialNoUtil;


@Controller
@RequestMapping("donateFront")
public class DonateAction {
	
	@Autowired
	private WeiXinUserService userService;
	
	@Autowired
	private ProjectService projectService;
	
	
	@Autowired
	private DonateRecordProjectService service;
	
	@Autowired
	private DonateRecordService donateService;
	
	
	@Autowired
	private ActivityService activityService;
	
	@RequestMapping(value="toDonate")
	public String toDonate(HttpServletRequest request,ModelMap map,String projectId,String actId,String name,String phone,String idcard,String exPhone)throws Exception{
		
		Long userId =userService.getSessionUserId(request.getSession());
		Long pId=null;
		
		
		if(actId!=null&&!actId.equals("null")&&!actId.trim().equals("")){
			
			Activity act = activityService.getActivity(new Long(actId));
			projectId = act.getProjectId().toString();
			
			
			map.put("actId",actId);
			map.put("name", name);
			map.put("phone", phone);
			map.put("idcard", idcard);
			map.put("exPhone", exPhone);
			if(userId==null){
				return "redirect:/weixinUser/toLoginByMini.action?url=/donateFront/toDonate.action"+"&parameters=actId="+actId;
			}
		}
		
		if(projectId!=null&&!projectId.equals("null")&&!projectId.trim().equals("")){
			pId=new Long(projectId);
		}
		
		if(userId==null){
			return "redirect:/weixinUser/toLoginByMini.action?url=/donateFront/toDonate.action"+"&parameters=projectId="+pId;
		}else{
			Map<String,Object> poj=projectService.find(pId);
			map.put("poj", poj);
			map.put("name", name);
			map.put("projectId", pId);
		}
		
		return "pycsh/donate/donate";
	}

	
	@RequestMapping(value="saveDonateRecord")
	public void saveDonateRecord(HttpServletRequest request,HttpServletResponse response,Long projectId,Double money)throws Exception{
		Long userId =userService.getSessionUserId(request.getSession());
		if(userId!=null){
			
			if(projectId!=null){
				
				service.saveRecord(projectId, userId, money, 1,null);
			}else{
				donateService.saveRecord(userId, money, 1);
			}
		response.getWriter().print("ok");
		}else{
			response.getWriter().print("notLogin");
		}
		
		
	}
	
	@RequestMapping(value="getDonateSum")
	public void getDonateSum(HttpServletRequest request,HttpServletResponse response)throws Exception{
		JSONUtil.printToHTML(response, donateService.getDonateSum());
		
	}
	
	
	@RequestMapping(value="loadDonateList")
	public void loadDonateList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize)throws Exception{
		JSONUtil.printToHTML(response, donateService.findRecordByPage(null, currentPage, pageSize));
		
	}
	
	@RequestMapping(value="checkIdcard")
	public void checkIdcard(HttpServletRequest request,HttpServletResponse response,String idcard,Long actId)throws Exception{
		response.setCharacterEncoding("UTF-8");
		if(actId!=null){
			if(idcard!=null&&idcard.length()==15||idcard.length()==18){
				
				if(activityService.findActRecord(actId, idcard).size()>0){
					response.getWriter().print("身份证重复!");
				}else{
					response.getWriter().print("ok");
				}
			}else{
				response.getWriter().print("身份证不正确!");
			}
		}else{
			response.getWriter().print("ok");
		}
		
	}
}
