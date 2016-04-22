package com.pycsh.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.util.JSONUtil;
import com.pycsh.model.Activity;
import com.pycsh.model.ActivityRecord;
import com.pycsh.service.ActivityService;
import com.pycsh.service.DonateRecordService;
import com.pycsh.service.SendMsgService;


@Controller
@RequestMapping("sendMsg")
public class SendMsgAction {
	
	@Autowired
	private SendMsgService service;
	
	@Autowired
	private DonateRecordService donateRecordService;
	
	@Autowired
	private ActivityService activityService;
	
	@RequestMapping(value="toList")
	public String toList(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		return "pycsh/sendMsg/list";
	}

	@RequestMapping(value="loadList")
	public void loadList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Integer type)throws Exception{
		JSONUtil.printToHTML(response, service.findByPage(currentPage, pageSize, type));
	}
	
	@RequestMapping(value="getLastMsgConunt")
	public void getLastMsgConunt(HttpServletResponse response,HttpServletRequest request,Long projectId,Long actId)throws Exception{
		
		
		
		if(projectId!=null){
			List<Map<String,Object>> recordList =donateRecordService.findRecordProject(projectId);
			if(service.getLastCount()-recordList.size()>0){
				response.getWriter().print("ok");
			}else{
				response.getWriter().print("countOut");
			}
		}else{
			List<ActivityRecord> actList = activityService.findActRecord(actId, null);
			if(service.getLastCount()-actList.size()>0){
				response.getWriter().print("ok");
			}else{
				response.getWriter().print("countOut");
			}
		}
		
	}
	
	@RequestMapping(value="sendMsg")
	public void sendMsg(HttpServletResponse response,HttpServletRequest request,Long projectId,Long actId,String text)throws Exception{
		if(projectId!=null){
			List<Map<String,Object>> recordList =donateRecordService.findRecordProject(projectId);
			if(service.getLastCount()-recordList.size()>0){
				StringBuffer strb = new StringBuffer();
				for(Map<String,Object> rc:recordList){
					if(rc.get("isSendMsg")==null||rc.get("isSendMsg").equals(0)){
						//strb.append(rc.get(key))
					}
				}
				//service.sendMsg(mobilesStr, msgContent)
			}else{
				response.getWriter().print("countOut");
			}
		}else{
			List<ActivityRecord> actList = activityService.findActRecord(actId, null);
			if(service.getLastCount()-actList.size()>0){
				List<String> phoneList =new ArrayList<String>();
				for(ActivityRecord ar:actList){
					if((ar.getPhone()!=null&&!ar.getPhone().trim().equals(""))&&phoneList.indexOf(ar.getPhone())==-1&&isNumber(ar.getPhone())&&ar.getPhone().length()==11){
						phoneList.add(ar.getPhone());
					}
					
				}
				if(phoneList.size()>0){
					if(service.sendMsg(phoneList.toString().replaceAll("\\[|\\]| ", ""), text)){
						for(String phone:phoneList){
							service.saveMsgRecord(phone, text, 3);
						}
						for(ActivityRecord ar:actList){
							ar.setIsSendMsg(1);
							
							activityService.updateActRecord(ar);
						}
						response.getWriter().print("ok");
					}else{
						response.getWriter().print("sendError");
					}
				}else{
					response.getWriter().print("noSendPhone");
				}
			}else{
				response.getWriter().print("countOut");
			}
		}
		
		
	}
	
	
	@RequestMapping(value="sendMsgByPhone")
	public void sendMsgByPhone(HttpServletResponse response,HttpServletRequest request,String phoneStr,String text)throws Exception{

		List<String> phoneList=new ArrayList<String>();
		if(phoneStr!=null&&phoneStr.length()>0){
			for(String phone:phoneStr.split(",")){
				phoneList.add(phone);
			}
		}
		if(service.getLastCount()-phoneList.size()>=0){
			
			if(phoneList.size()>0){
				if(service.sendMsg(phoneList.toString().replaceAll("\\[|\\]| ", ""), text)){
					for(String phone:phoneList){
						service.saveMsgRecord(phone, text, 3);
					}
	
					response.getWriter().print("ok");
				}else{
					response.getWriter().print("sendError");
				}
			}else{
				response.getWriter().print("noSendPhone");
			}
		}else{
			response.getWriter().print("countOut");
		}

		
	}
	
	 private boolean isNumber(String number)  
	    {  
	        Pattern pattern = Pattern.compile("[0-9]*");  
	        Matcher matcher = pattern.matcher(number);  
	          
	        if (matcher.matches())  
	        {  
	            return true;  
	        }  
	        return false;  
	    }  
	
	
}
