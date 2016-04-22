package com.pycsh.action;
import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.authority.model.User;
import com.base.config.Init;
import com.base.util.DataUtil;
import com.base.util.FileUtil;
import com.base.util.ImageUitl;
import com.base.util.JSONUtil;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.pycsh.model.Project;
import com.pycsh.service.ProjectService;
import com.pycsh.service.ProjectTypeService;
import com.site.vo.ArticleSearchVo;

@Controller
@RequestMapping("project")
public class ProjectAction {

	@Autowired
	private ProjectService projectService;
	@Autowired
	private ProjectTypeService projectTypeService;
	
	/**
	 * 跳转到首页
	 * @return
	 */
	@RequestMapping("index")
	public String index(ModelMap map){
		return "pycsh/project/index";
	}
	/**
	 * 跳转到新增页面
	 * @return
	 */
	@RequestMapping("add")
	public String add(ModelMap map){
		map.put("typeList", projectTypeService.getList("0", "project"));
		return "pycsh/project/add";
	}
	/**
	 * 跳转到修改页面
	 * @return
	 */
	@RequestMapping("toEdit")
	public String toEdit(ModelMap map,Long id){
		map.put("typeList", projectTypeService.getList("0", "project"));
		map.put("project", projectService.find(id));
		return "pycsh/project/edit";
	}
	/**
	 * 跳转到查看页面
	 * @return
	 */
	@RequestMapping("toView")
	public String toView(ModelMap map,Long id){
		map.put("project", projectService.find(id));
		return "pycsh/project/view";
	}
	/**
	 * 获取列表数据
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("list")
	public void list(HttpServletRequest request, HttpServletResponse response, Integer currentPage, Integer pageSize,
			String name,String startTime,String endTime,String status,String type1,String type2){
		try {
			currentPage = Init.getCurrentPage(currentPage);
			pageSize = Init.getPageSize(pageSize);
			PageList pageList = projectService.getPageList(currentPage, pageSize, name, startTime, endTime, status, type1, type2);
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
			Map<String, Object> project = new HashMap<String, Object>();
			project.put("userId", User.getCurrentUserId(request));
			project.put("name",name);
			project.put("type1",type1);
			project.put("type2",type2);
			project.put("targer",targer);
			project.put("startTime",startTime);
			project.put("endTime",endTime);
			project.put("introduce", introduce);
			project.put("contents", content);
			if(StringUtil.isEmpty(smallPicUrl)){
				smallPicUrl="/skins/images/projectSmall.jpg";
			}
			if(StringUtil.isEmpty(smallPicOriginalUrl)){
				
				smallPicOriginalUrl="/skins/images/60/projectOrigina.jpg";
			}
			project.put("smallPicOriginalUrl", smallPicOriginalUrl);
			
			project.put("clickCount", 0);
			project.put("viewCount", 0);
			project.put("isDelete", 0);
			project.put("isOpen", 0);
			project.put("status", 1);
			project.put("checked", 0);
			project.put("modifed", new Date());
			Serializable id = projectService.save(project);
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
	@RequestMapping("update")
	public void update(HttpServletRequest request, HttpServletResponse response,Long id, String name,
			String type1,String type2,String targer,String startTime,String endTime,String introduce,String content,
			String smallPicUrl, String smallPicOriginalUrl){
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
			Map<String, Object> project = projectService.find(id);
			project.remove("typeName");
			project.remove("type2Name");
			project.put("userId", User.getCurrentUserId(request));
			project.put("name",name);
			project.put("type1",type1);
			project.put("type2",type2);
			project.put("targer",targer);
			project.put("startTime",startTime);
			project.put("endTime",endTime);
			project.put("introduce", introduce);
			project.put("contents", content);
			project.put("smallPicUrl", smallPicUrl);
			project.put("smallPicOriginalUrl", smallPicOriginalUrl);
			project.put("modifed", new Date());
			project.remove("startTimeFormat");
			project.remove("endTimeFormat");
			projectService.update(project);
			JSONUtil.print(response, Init.SUCCEED);
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
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
    
	 /**
	 * 更新文章相对应最后修改时间的排序
	 * @author lifq
	 * @param id 文章ID
	 * @param flag 更新标识：1、上移一条;2、下移一条;3、置顶;4、置尾
	 * @return
	 */
	@RequestMapping(value="updateArticleSort") 
	public void updateArticleSort(HttpServletResponse response,Integer id,Integer flag){
			try {
				if (id!=null&&id!=0&&flag!=null&&flag!=0) {
					projectService.updateProjectSort(id, flag);
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
	public void upateOpenStatus(HttpServletResponse response,Integer id,Integer flag){
		try {
			if (id!=null&&id!=0) {
				projectService.updateOpenStatus(id, flag);
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
				projectService.delete(ids);
				JSONUtil.print(response,Init.SUCCEED);
			}else{
				JSONUtil.print(response, Init.FAIL);
			}
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	/**
	 * 跳转到修改进展页面
	 * @return
	 */
	@RequestMapping("toUpdateProgress")
	public String toUpdateProgress(ModelMap map,Long id){
		map.put("projectId", id);
		return "pycsh/project/updateProgress";
	}
	/**修改项目的进展(1：发起，2：审核，3：募款，4：执行，5：结束)
	 * @param response
	 * @param id
	 * @param flag
	 */
	@RequestMapping(value="upateProjectStatus") 
	public void upateProjectStatus(HttpServletResponse response,Integer id,String progress){
		try {
			if (id!=null&&id!=0) {
				projectService.updateProjectStatus(id, progress);
				JSONUtil.print(response,Init.SUCCEED);
			}else{
				JSONUtil.print(response, Init.FAIL);
			}
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
}
