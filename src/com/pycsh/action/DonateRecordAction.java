package com.pycsh.action;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.authority.model.User;
import com.base.config.Init;
import com.base.util.JSONUtil;
import com.base.vo.PageList;
import com.pycsh.service.DonateRecordProjectService;
import com.pycsh.service.DonateRecordService;
import com.pycsh.service.ProjectService;
import com.pycsh.service.SendMsgService;
import com.pycsh.service.WeiXinUserService;

@Controller
@RequestMapping("donateRecord")
public class DonateRecordAction {

	@Autowired
	private DonateRecordProjectService donateRecordService;
	
	@Autowired
	private DonateRecordService service;
	
	@Autowired
	private SendMsgService sendMsgService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private WeiXinUserService userService;
	
	
	/**
	 * 跳转到首页
	 * @return
	 */
	@RequestMapping("index")
	public String index(ModelMap map){
		return "pycsh/donateRecord/index";
	}
	
	/**
	 * 跳转到查看页面
	 * @return
	 */
	@RequestMapping("toView")
	public String toView(ModelMap map,Long id){
		map.put("donate", donateRecordService.find(id));
		return "pycsh/donateRecord/view";
	}
	/**
	 * 获取列表数据
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("list")
	public void list(HttpServletRequest request, HttpServletResponse response, Integer currentPage, Integer pageSize,
			String name,String startTime,String endTime,String phone,String projectName,String userName){
		try {
			currentPage = Init.getCurrentPage(currentPage);
			pageSize = Init.getPageSize(pageSize);
			PageList pageList = donateRecordService.getPageList(currentPage, pageSize, phone, projectName, userName, startTime, endTime);
			//pageList.setList(DataUtil.deleteListMapByKey((List<Map<String, Object>>) pageList.getList(), "content")) ;
			JSONUtil.printToHTML(response, pageList);
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	
	@RequestMapping("save")
	public void save(HttpServletRequest request, HttpServletResponse response, String name,
			String type1,String type2,String targer,String startTime,String endTime,String introduce,String content,
			String smallPicUrl, String smallPicOriginalUrl){
		try {
			Map<String, Object> project = new HashMap<String, Object>();
			project.put("userId", User.getCurrentUserId(request));
			project.put("name",name);
			project.put("type1",type1);
			
			Serializable id = 1;
			if(id!=null){
				JSONUtil.print(response, Init.SUCCEED);
			}else{
				JSONUtil.print(response, Init.FAIL);
			}
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}

	@RequestMapping(value="toRecordList")
	public String toRecordList(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		return "pycsh/donateRecord/recordList";
	} 
	
	
	@RequestMapping(value="loadRecordList")
	public void loadRecordList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Long userId)throws Exception{
		
		PageList pageList=service.findRecordByPage(userId, currentPage, pageSize);
		JSONUtil.printToHTML(response, pageList);
	}
	
	@RequestMapping(value="toProjectList")
	public String toProjectList(HttpServletRequest request,HttpServletResponse response,Long donateId,Integer currentPage,Integer pageSize,ModelMap map)throws Exception{
		map.put("donateId", donateId);
		Map<String,Object> record = service.getRecord(donateId);
		map.put("lastMoney", record.get("lastMoney"));
		return "pycsh/donateRecord/projectList";
	}
	
	@RequestMapping(value="toSelectDonate")
	public String toSelectDonate(HttpServletRequest request,ModelMap map,Long projectId,Long donateId)throws Exception{
		map.put("projectId", projectId);
		map.put("donateId", donateId);
		return "pycsh/donateRecord/selectDonate";
	}
	
	@RequestMapping(value="saveSelectDonate")
	public void saveSelectDonate(HttpServletRequest request,HttpServletResponse response,Long projectId,Long donateId,Double money)throws Exception{
		
		donateRecordService.saveRecordByDonate(donateId, projectId, money,getSessionUserId(request));
		Map<String,Object> donate= service.getRecord(donateId);
		Map<String,Object> project= projectService.find(projectId);
		Map<String,Object> user= userService.getUserById((Long)donate.get("userId"));
		SimpleDateFormat sdf =new SimpleDateFormat("yyyy年MM月dd日 HH时mm分");
		String userName="";
		if(user.get("name")!=null){
			userName=user.get("name").toString();
		}else{
			userName="会员";
		}
	
		String str="亲爱的"+userName+" 你于"+sdf.format((Date)donate.get("createTime"))+" 的慈善捐款经慈善会商议,已将"+money+"元 分配到"+project.get("name")+" 慈善项目中。 ";
		if(sendMsgService.getLastCount()>0){
			sendMsgService.sendMsg(user.get("loginName").toString(), str);
			sendMsgService.saveMsgRecord(user.get("loginName").toString(), str,2);
		}
		
		response.getWriter().print("ok");
	}
	
	@RequestMapping(value="loadDonateRecord")
	public void loadDonateRecord(HttpServletRequest request ,HttpServletResponse response,Long id)throws Exception{
		
		List<Map<String,Object>> list = service.findRecordProject(id);
		JSONUtil.printToHTML(response, list);
		
	}
	
	private Map<String,Object> getSessionUser(HttpServletRequest request){
		Map<String,Object> user = (Map<String,Object>)request.getSession().getAttribute(Init.AUTHORITY_USER);
		return user;
	}
	
	private Integer getSessionUserId(HttpServletRequest request){
		Map<String,Object> user =getSessionUser(request);
		
		return (Integer)user.get("id");
	}
	
	
}
