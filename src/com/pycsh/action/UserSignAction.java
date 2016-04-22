package com.pycsh.action;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.text.SimpleDateFormat;
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

import com.authority.model.User;
import com.base.config.Init;
import com.base.util.FileUtil;
import com.base.util.ImageUitl;
import com.base.util.JSONUtil;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.pycsh.model.CharityProject;
import com.pycsh.model.CharityRecord;
import com.pycsh.model.UserSign;
import com.pycsh.service.ProjectTypeService;
import com.pycsh.service.UserSignService;
import com.pycsh.service.WeiXinUserService;
import com.site.service.ImageService;

@Controller
@RequestMapping(value="userSign")
public class UserSignAction {
	
	@Autowired
	private UserSignService service;
	
	@Autowired
	private WeiXinUserService userService;
	
	@Autowired
	private ProjectTypeService projectTypeService;
	
	
	@RequestMapping(value="getUserSign")
	public void getUserSign(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Long userId = userService.getSessionUserId(request.getSession());
		Map<String,Object> us = service.getUserSignByUserId(userId);
		if(us!=null){
			List<Map<String,Object>> imgList = service.findUserSignImg(userId);
			us.put("imgList", imgList);
		}
		
		JSONUtil.printToHTML(response, us);
	}

	@RequestMapping(value="saveUserSign")
	public void saveUserSign(HttpServletRequest request,HttpServletResponse response,String company,String corporation,String contact,String contactPhone,String smallPicUrl,String[] imgUrls,String email)throws Exception{
		
		Long userId = userService.getSessionUserId(request.getSession());
		Long usId = service.saveUserSign(company, corporation, contact, contactPhone,email,smallPicUrl, userId);
		service.deleteUserSignImg(null, userId);
		if(imgUrls!=null){
			for(String imgUrl:imgUrls){
				service.saveUserSignImg(userId, usId, imgUrl);
			}
		}
		response.getWriter().print("ok");
		
	}
	
	@RequestMapping(value="saveCharityProject")
	public void saveCharityProject(HttpServletRequest request,HttpServletResponse response,String name, String content,Integer type,Integer amount,String introduce,Double targer,String smallPicUrl,String smallPicOriginalUrl,String application,String originalName)throws Exception{
		Long userId = userService.getSessionUserId(request.getSession());
		CharityProject cp =new CharityProject();
		
		cp.setName(name);
		cp.setStatus(0);
		cp.setType(type);
		cp.setAmount(amount);
		cp.setContents(content);
		cp.setIntroduce(introduce);
		cp.setTarger(targer);
		cp.setUserId(userId);
		cp.setApplication(application);
		cp.setOriginalName(originalName);
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
		if(StringUtil.isEmpty(smallPicUrl)){
			
			smallPicUrl="/skins/images/projectSmall.jpg";
		}
		if(StringUtil.isEmpty(smallPicOriginalUrl)){
			
			smallPicOriginalUrl="/skins/images/60/projectOrigina.jpg";
		}
		cp.setSmallPicOriginalUrl(smallPicOriginalUrl);
		cp.setSmallPicUrl(smallPicUrl);
		cp.setClickCount(0l);
		cp.setViewCount(0l);
		cp.setIsDelete(0);
		cp.setIsOpen(0);
		cp.setModifed(new Date());
		cp.setStatus(1);
		cp.setChecked(0);
		

		Serializable id = service.saveCharityProject(cp);
		if(id!=null){
			JSONUtil.print(response, Init.SUCCEED);
		}else{
			JSONUtil.print(response, Init.FAIL);
		}
		
	}
	
	
	@RequestMapping("updateCharityProject")
	public void updateCharityProject(HttpServletRequest request, HttpServletResponse response,Long id, String name,
			Integer type,Double targer,String introduce,String content,
			String smallPicUrl, String smallPicOriginalUrl,String application,String originalName){
		try {
			// 如果没有上传缩略图则获取正文内容第一张图片作为缩略图
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
			CharityProject cp= service.getCharityProject(id);
			cp.setName(name);
			cp.setStatus(0);
			cp.setType(type);
			cp.setContents(content);
			cp.setIntroduce(introduce);
			cp.setTarger(targer);
			cp.setApplication(application);
			cp.setOriginalName(originalName);
			cp.setSmallPicOriginalUrl(smallPicOriginalUrl);
			cp.setSmallPicUrl(smallPicUrl);
			cp.setClickCount(0l);
			cp.setViewCount(0l);
			cp.setIsDelete(0);
			cp.setIsOpen(0);
			cp.setModifed(new Date());
			cp.setStatus(1);
			cp.setChecked(0);
			
			service.updateCharityProject(cp);
			
			JSONUtil.print(response, Init.SUCCEED);
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value="loadCharityProject")
	public void loadCharityProject(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,String name,Integer status)throws Exception{
		Long userId = userService.getSessionUserId(request.getSession());
		PageList<Map<String,Object>> pageList = service.findCharityProjectByPage(currentPage, pageSize, status, userId, null, name);
		JSONUtil.printToHTML(response, pageList);
	}
	
	@RequestMapping(value="toUploadRegisterImg")
	public String toUploadUserImg(HttpServletRequest request,ModelMap map)throws Exception{
		Long userId =  userService.getSessionUserId(request.getSession());
		Map<String,Object> userSign= service.getUserSignByUserId(userId);
		if(userSign!=null){
			
			map.put("registerImgUrl", userSign.get("registerImgUrl"));//临时文件关联ID
		}
		
		return "pycsh/weixinUser/uploadRegisterImg";
	}
	
	@RequestMapping(value="toUploadPromise")
	public String toUploadPromise(HttpServletRequest request,ModelMap map)throws Exception{
		
		return "pycsh/weixinUser/uploadPromise";
	}
	
	@RequestMapping(value="updatePromise")
	public void updatePromise(HttpServletRequest request,HttpServletResponse response,String promise)throws Exception{
		Long userId =  userService.getSessionUserId(request.getSession());
		Map<String,Object> userSign= service.getUserSignByUserId(userId);
		if(promise!=null&&!promise.trim().equals("")){
			userSign.put("promise", promise);
			service.updateUserSign(userSign);
		}
		response.getWriter().print("ok");
		
	}
	
	@RequestMapping(value="updateApplication")
	public void updateApplication(HttpServletRequest request,HttpServletResponse response,String application)throws Exception{
		Long userId =  userService.getSessionUserId(request.getSession());
		Map<String,Object> userSign= service.getUserSignByUserId(userId);
		if(application!=null&&!application.trim().equals("")){
			userSign.put("application", application);
			service.updateUserSign(userSign);
		}
		response.getWriter().print("ok");
		
	}
	
	
	@RequestMapping(value="updateRegisterImg")
	public void updateRegisterImg(HttpServletRequest request,HttpServletResponse response,String smallPicUrl)throws Exception{
		Long userId =userService.getSessionUserId(request.getSession());
		Map<String,Object> user = service.getUserSignByUserId(userId);
		if(smallPicUrl!=null&&!smallPicUrl.trim().equals("")){
			
			user.put("registerImgUrl", smallPicUrl);
		}
		service.updateUserSign(user);
		response.getWriter().print("ok");
	}
	
	@RequestMapping(value="deleteImg")
	public void deleteImg(HttpServletRequest request,HttpServletResponse response,Long id)throws Exception{
		Long userId =userService.getSessionUserId(request.getSession());
		service.deleteUserSignImg(id, userId);
		response.getWriter().print("ok");
	}
	
	
	/**
	 * 跳转到新增页面
	 * @return
	 */
	@RequestMapping("add")
	public String add(ModelMap map){
		map.put("typeList", projectTypeService.getList("0", "game"));
		return "pycsh/userSign/add";
	}
	
	@RequestMapping("update")
	public String update(ModelMap map,Long id){
		map.put("typeList", projectTypeService.getList("0", "game"));
		map.put("project", service.getCharityProject(id));
		return "pycsh/userSign/add";
	}
	
	@RequestMapping(value="loadCharityProjectList")
	public void loadCharityProjectList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,String name,Integer type)throws Exception{
		
		PageList<Map<String,Object>> pageList =service.findCharityProjectByPage(currentPage, pageSize, name, type);
		JSONUtil.printToHTML(response, pageList);
	}
	
	@RequestMapping(value="getCharityMoney")
	public void getCharityMoney(HttpServletResponse response,HttpServletRequest request,Long[] ids)throws Exception{
		List<Long> idList=new ArrayList<Long>();
		if(ids!=null){
			for(Long id:ids){
				idList.add(id);
			}
		}
		List<Map<String,Object>> list =service.getCharityMoney(idList);
		JSONUtil.printToHTML(response, list);
	}
	
	@RequestMapping(value="getCharityProject")
	public void getCharityProject(HttpServletRequest request,HttpServletResponse response,Long id)throws Exception{
		Map<String,Object> cp =service.getCharityProjectByMap(id);
		if(cp!=null){
			Map<String,Object> us=service.getUserSignByUserId((Long)cp.get("userId"));
			if(us!=null){
				cp.put("company",us.get("company"));
			}
		}
		JSONUtil.printToHTML(response, cp);
		
	}
	
	@RequestMapping(value="getCharityRecord")
	public void getCharityRecord(HttpServletResponse response,HttpServletRequest request,Long id)throws Exception{
		List<Map<String,Object>> list = service.getCharityRecordList(id);
		JSONUtil.printToHTML(response, list);
	}
	
	@RequestMapping(value="loadCharityRecord")
	public void loadCharityRecord(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize)throws Exception{
		PageList<Map<String,Object>> pageList =service.LoadCharityDonateRecord(currentPage, pageSize);
		JSONUtil.printToHTML(response, pageList);
	}
	
	
	@RequestMapping(value="toCharityRecordList")
	public String toCharityRecordList(HttpServletRequest request,HttpServletResponse response,Long id,ModelMap map)throws Exception{
		map.put("id", id);
		return "pycsh/charityProject/record";
	}
	
	@RequestMapping(value="loadCharityRecordList")
	public void loadCharityRecordList(HttpServletRequest request,HttpServletResponse response,Integer currentPage,Integer pageSize,Long id)throws Exception{
		PageList<Map<String,Object>> pageList =service.LoadCharityRecord(currentPage, pageSize,id);
		JSONUtil.printToHTML(response, pageList);
	}
	
	@RequestMapping(value="submitProject")
	public void submitProject(HttpServletResponse response,HttpServletRequest request,Long id)throws Exception{
		Long userId =userService.getSessionUserId(request.getSession());
		CharityProject cp =service.getCharityProject(id);
		//判断是否自己创建的项目
		if(cp.getUserId().equals(userId)){
			cp.setStatus(2);
			cp.setChecked(0);
			service.updateCharityProject(cp);
		}
		
		response.getWriter().print("ok");
	}
	
	@RequestMapping(value="toAddRecord")
	public String toAddRecord(HttpServletRequest request,HttpServletResponse response,Long id,ModelMap map)throws Exception{
		
		map.put("id", id);
		return "pycsh/charityProject/addRecord";
		
	}
	
	@RequestMapping(value="saveCharityRecord")
	public void saveCharityRecord(HttpServletRequest request,HttpServletResponse response,String title,String content,String recordTime,Long id)throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		service.saveCharityRecord(title, content, sdf.parse(recordTime), id);
		response.getWriter().print("ok");
	}
	
	@RequestMapping(value="toUpdateRecord")
	public String toUpdateRecord(HttpServletRequest request,HttpServletResponse response,Long id,ModelMap map)throws Exception{
		
		CharityRecord cr = service.getCharityRecord(id);
		map.put("cr", cr);
		return "pycsh/charityProject/addRecord";
	}
	
	@RequestMapping(value="updateCharityRecord")
	public void updateCharityRecord(HttpServletRequest request,HttpServletResponse response,String title,String content,String recordTime,Long id)throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		CharityRecord cr = service.getCharityRecord(id);
		cr.setContents(content);
		cr.setRecordTime(sdf.parse(recordTime));
		
		cr.setTitle(title);
		service.updateCharityRecord(cr);
		response.getWriter().print("ok");
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
