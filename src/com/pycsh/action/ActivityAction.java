package com.pycsh.action;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.authority.model.User;
import com.authority.service.UserService;
import com.base.config.Init;
import com.base.util.ExcelExportUtil;
import com.base.util.FileUtil;
import com.base.util.ImageUitl;
import com.base.util.JSONUtil;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.pycsh.model.Activity;
import com.pycsh.model.ActivityRecord;
import com.pycsh.model.DonateRecordTemp;
import com.pycsh.service.ActivityService;
import com.pycsh.service.ProjectService;
import com.site.service.ImageService;


@Controller
@RequestMapping(value = "activity")
public class ActivityAction {
	
	@Autowired
	private ActivityService service;
	
	@Autowired
	private UserService userService;
	
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private ImageService imageService;
	
	@RequestMapping(value="toAddActivity")
	public String toAddActivity(HttpServletRequest request,HttpServletResponse response,ModelMap map)throws Exception{
	
		
		return "/pycsh/activity/add";
	}
	
	@RequestMapping(value="saveActivity")
	public void saveActivity(HttpServletRequest request,HttpServletResponse response, String name,
			String startTime,String endTime,String introduce,String content,
			String smallPicUrl, String smallPicOriginalUrl,Long projectId,String attachmentIds)throws Exception{
		
		//判断是否上传缩略图,如果没有则从正文内容中提取第一张图片做缩略图
		if(StringUtil.isEmpty(smallPicUrl) && !StringUtil.isEmpty(content)){
            try {
                String result = getContentImage(request, content);
                if(result != null){
                    smallPicOriginalUrl = smallPicUrl = result;
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Activity act =new Activity();
		act.setStartTime(sdf.parse(startTime));
		act.setEndTime(sdf.parse(endTime));
		act.setUserId(new Long(User.getCurrentUserId(request)));
		act.setViewCount(0l);
		act.setCreTime(new Date());
		act.setClickCount(0l);
		act.setStatus(1);
		act.setIsDelete(0);
		act.setIsOpen(0);
		act.setName(name);
		act.setProjectId(projectId);
		act.setIntroduce(introduce);
		act.setContents(content);
		
		if(StringUtil.isEmpty(smallPicUrl)){
			
			smallPicUrl="/skins/images/projectSmall.jpg";
		}
		if(StringUtil.isEmpty(smallPicOriginalUrl)){
			
			smallPicOriginalUrl="/skins/images/60/projectOrigina.jpg";
		}
		act.setSmallPicOriginalUrl(smallPicOriginalUrl);	
		act.setSmallPicUrl(smallPicUrl);
		
		service.saveActivity(act);
		if(attachmentIds!=null&&!attachmentIds.equals("")){

			imageService.updateImageArticleId(act.getId().intValue(), attachmentIds);
		}
		response.getWriter().print("ok");
		
	}
	
	
	@RequestMapping(value="toUpdateActivity")
	public String toUpdateActivity(HttpServletRequest request,HttpServletResponse response,ModelMap map,Long id)throws Exception{
		Activity act = service.getActivity(id);
		map.put("project", act);
		if(act.getProjectId()!=null){
			map.put("projectName", projectService.find(act.getProjectId()).get("name"));
		}
		List<Map<String,Object>> fileList = imageService.find(id.intValue(), 3, null, null);
		map.put("fileList", fileList);
		return "/pycsh/activity/edit";
	}
	
	
	@RequestMapping(value="updateActivity")
	public void updateActivity(HttpServletRequest request, HttpServletResponse response,Long id, String name,
			Integer type1,Integer type2,String targer,String startTime,String endTime,String introduce,String content,
			String smallPicUrl, String smallPicOriginalUrl,String attachmentIds)throws Exception{
		
		
		if(StringUtil.isEmpty(smallPicUrl) && !StringUtil.isEmpty(content)){
			try {
				String result = getContentImage(request, content);
				if(result != null){
					smallPicOriginalUrl = smallPicUrl = result;
				}
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Activity act =service.getActivity(id);
		act.setStartTime(sdf.parse(startTime));
		act.setEndTime(sdf.parse(endTime));
		act.setName(name);

		act.setIntroduce(introduce);
		act.setContents(content);

		if(StringUtil.isEmpty(smallPicUrl)){
			
			smallPicUrl="/skins/images/projectSmall.jpg";
		}
		if(StringUtil.isEmpty(smallPicOriginalUrl)){
			
			smallPicOriginalUrl="/skins/images/60/projectOrigina.jpg";
		}
		act.setSmallPicOriginalUrl(smallPicOriginalUrl);	
		act.setSmallPicUrl(smallPicUrl);
		act.setModifed(new Date());
		service.updateActivity(act);
		
		
		if(attachmentIds!=null&&!attachmentIds.equals("")){

			imageService.updateImageArticleId(act.getId().intValue(), attachmentIds);
		}
		response.getWriter().print("ok");
	}
	
	@RequestMapping(value="toList")
	public String toList(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		return "/pycsh/activity/index";
	}
	
	
	@RequestMapping(value="loadList")
	public void loadList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,String name)throws Exception{
		
		PageList pageList =service.findActivityByPage(currentPage, pageSize, null,null,name);
		JSONUtil.printToHTML(response, pageList);
	}
	
	

	
	
	@RequestMapping(value="toProjectList")
	public String toProjectList()throws Exception{
		
		return "pycsh/activity/projectList";
	}
	
	
	@RequestMapping(value="toViewActivity")
	public String toViewActivity(HttpServletRequest request,HttpServletResponse response,ModelMap map,Long id)throws Exception{
		Activity act = service.getActivity(id);
		map.put("project", act);
		map.put("projectName", projectService.find(act.getProjectId()).get("name"));
		return "/pycsh/activity/view";
		
	}
	
	/**
	 * 跳转到修改进展页面
	 * @return
	 */
	@RequestMapping("toUpdateProgress")
	public String toUpdateProgress(ModelMap map,Long id){
		map.put("actId", id);
		return "pycsh/activity/updateProgress";
	}
	
	
	/**修改项目的进展(1：发起，2：审核，3：募款，4：执行，5：结束)
	 * @param response
	 * @param id
	 * @param flag
	 */
	@RequestMapping(value="upateActivityStatus") 
	public void upateActivityStatus(HttpServletResponse response,Long id,Integer progress){
		try {
			if (id!=null&&id!=0) {
				Activity act =service.getActivity(id);
				act.setStatus(progress);
				act.setModifed(new Date());
				service.updateActivity(act);
				JSONUtil.print(response,Init.SUCCEED);
			}else{
				JSONUtil.print(response, Init.FAIL);
			}
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	
	
	/**修改项目的开放状态
	 * @param response
	 * @param id
	 * @param flag
	 */
	@RequestMapping(value="upateOpenStatus") 
	public void upateOpenStatus(HttpServletResponse response,Long id,Integer flag){
		try {
			if (id!=null&&id!=0) {
				Activity act =service.getActivity(id);
				act.setIsOpen(flag);
				act.setModifed(new Date());
				service.updateActivity(act);
				JSONUtil.print(response,Init.SUCCEED);
			}else{
				JSONUtil.print(response, Init.FAIL);
			}
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	
	/**删除项目
	 * @param response
	 * @param id
	 */
	@RequestMapping(value="delete") 
	public void delete(HttpServletResponse response,Integer ids){
		try {
			if (ids!=null&&ids!=0) {
				service.deleteActivity(new Long(ids));
				JSONUtil.print(response,Init.SUCCEED);
			}else{
				JSONUtil.print(response, Init.FAIL);
			}
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="toRecordList")
	public String toRecordList(HttpServletRequest request,HttpServletResponse response,ModelMap map,Long actId)throws Exception{
		map.put("actId", actId);
		return "/pycsh/activity/recordList";
	}
	
	@RequestMapping(value="loadRecordList")
	public void loadRecordList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,String name,String idcard,String phone,String actName,String actId)throws Exception{
		Long tmpId = null;
		if(actId!=null&&!actId.trim().equals("")){
			tmpId = new Long(actId);
		}
		PageList pageList =service.findActRecordByPage(currentPage, pageSize, name, idcard, phone, actName,tmpId);
		JSONUtil.printToHTML(response, pageList);
	}
	
	
	@RequestMapping(value="exportRecord")
	public void exportRecord(HttpServletRequest request,HttpServletResponse response,Long actId)throws Exception{
		
		Activity act= service.getActivity(actId);
		//设置附件头信息
		response.setHeader( "Content-disposition", "attachment;  filename= "+URLEncoder.encode(act.getName(), "UTF-8")+URLEncoder.encode("报名名单.xls", "UTF-8")); 
		//建立excel文件
		WritableWorkbook wbook = Workbook.createWorkbook(response.getOutputStream());
		//建立工作本
		WritableSheet wsheet =wbook.createSheet("报名名单", 0);
		List<Object> titleList=new ArrayList<Object>();
		titleList.add("姓名");
		titleList.add("联系电话");
		titleList.add("身份证号");
		titleList.add("紧急联系电话");
		titleList.add("序列号");
		titleList.add("报名时间");
		titleList.add("捐款金额");
		titleList.add("捐款方式");
		//写入表头信息(第一行)
		ExcelExportUtil.getLabelList(0, titleList, null, 1, wsheet);
		List<ActivityRecord> recordList = service.findActRecord(actId, null);
		List<Long> recordIdList =new ArrayList<Long>();
		for(ActivityRecord ar:recordList){
			recordIdList.add(new Long(ar.getRecordId()));
		}
		List<DonateRecordTemp> rtList = service.findRecordTempByIds(recordIdList);
		Map<Integer,String> rtMap =new HashMap<Integer, String>();
		for(DonateRecordTemp rt:rtList){
			rtMap.put(rt.getId().intValue(), (rt.getType().equals(1) ? "支付宝" : "微信" ));
		}
		SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Integer index=0;
		for(ActivityRecord ar:recordList){
			titleList=new ArrayList<Object>();
			index++;
			titleList.add(ar.getName());
			titleList.add(ar.getPhone());
			titleList.add(ar.getIdcard());
			titleList.add(ar.getExPhone());
			titleList.add(ar.getCode());
			titleList.add(sdf.format(ar.getCreateTime()));
			titleList.add(ar.getMoney());
			titleList.add(rtMap.get(ar.getRecordId()));
			ExcelExportUtil.getLabelList(index, titleList, null, 1, wsheet);
		}
		//关闭输出流
		wbook.write();
		wbook.close();		
		
	}
	
	
	@RequestMapping(value="toActivitySignList")
	public String toActivitySignList(HttpServletResponse response,HttpServletRequest request,Long actId,ModelMap map)throws Exception{
		map.put("actId", actId);
		return "/pycsh/activity/signList";
	}
	
	
	@RequestMapping(value="loadSignList")
	public void loadSignList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Long actId)throws Exception{
		PageList pageList =service.findSignByPage(currentPage, pageSize, actId);
		JSONUtil.printToHTML(response, pageList);
	}
	
	 /**
     * 从正文中获取第一张图
     * @param request
     * @param content
     * @return
     * @throws IOException
     */
    private String getContentImage(HttpServletRequest request, String content) throws IOException {
        List<String> imgNodes = StringUtil.searchStr(content.toLowerCase(), "<img", ">");
        for(String imgNode : imgNodes){
            List<String> srcList = StringUtil.searchStr(imgNode, "src=\"", "\"");
            for(String src : srcList){
                String url = src.substring(5, src.length() -1).trim();
                if(url.charAt(0) == '/'){
                    String realPath = request.getSession().getServletContext().getRealPath("/");
                    File file = new File(realPath + url);
                    if(file.exists()){
                        File parent = file.getParentFile();
                        File newFile = new File(parent, "copy_" + file.getName());
                        FileUtil.copyFile(file, newFile);
                        String newUrl = newFile.getPath().substring(realPath.length()).replaceAll("\\\\{1,2}", "/");
                        String newFilePath = newFile.getPath();
                        ImageUitl.imageZip(newFilePath, newFilePath, 1024, 768, true);
                        return "/" + newUrl;
                    }
                }
            }
        }
        return null;
    }
    
    
	

}
