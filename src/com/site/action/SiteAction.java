package com.site.action;

import java.io.Serializable;
import java.util.HashMap;
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
import com.base.util.StringUtil;
import com.site.service.SiteService;

@Controller
@RequestMapping("site")
public class SiteAction {

	@Autowired
	private SiteService service;

	@RequestMapping("index")
	public String index(HttpServletRequest request, HttpServletResponse response){
		return "site/site/index";
	}
	@RequestMapping("list")
	public void list(HttpServletRequest request, HttpServletResponse response, Integer currentPage, Integer pageSize){
		currentPage = Init.getCurrentPage(currentPage);
		pageSize = Init.getPageSize(pageSize);
		String keyword = request.getParameter("keyword");
		Map<String, Object> pageListMap = service.getListByPage(currentPage, pageSize, keyword);
		JSONUtil.printToHTML(response, pageListMap);
	}
	@RequestMapping(value="add")
	public String add(HttpServletRequest request, HttpServletResponse response){
		return "site/site/add";
	}
	@RequestMapping(value="save")
	public void save(HttpServletRequest request, HttpServletResponse response){
		String name = request.getParameter("name");
		String domain = request.getParameter("domain");
		String directory = request.getParameter("directory");
		if(domain!=null && domain.startsWith("http://"))domain=domain.replace("http://", "");
		if(name==null || name.trim().equals("") || domain==null || domain.trim().equals("")){
			JSONUtil.print(response, Init.FAIL);
		}else{
			Serializable id = service.save(name, domain, directory);
			if(id!=null){
				JSONUtil.print(response, Init.SUCCEED);
			}else{
				JSONUtil.print(response, Init.FAIL);
			}
		}
	}
	@RequestMapping(value="delete")
	public void delete(HttpServletRequest request, HttpServletResponse response, Integer id){
		if(id==null || id<=0){
			JSONUtil.print(response, Init.FAIL);
		}else{
			int i = service.delete(id);
			JSONUtil.print(response, i>0?Init.SUCCEED:Init.FAIL);
		}
	}
	@RequestMapping(value="edit")
	public String edit(ModelMap map, HttpServletRequest request, HttpServletResponse response, Integer id){
		map.put("id", id);
		return "site/site/edit";
	}
	@RequestMapping(value="load")
	public void load(HttpServletRequest request, HttpServletResponse response, Integer id){
		Map<String, Object> map = service.load(id);
		JSONUtil.printToHTML(response, map);
	}
	@RequestMapping(value="update")
	public void update(HttpServletRequest request, HttpServletResponse response, Integer id){
		String name = request.getParameter("name");
		String domain = request.getParameter("domain");
		String directory = request.getParameter("directory");
		String isUseCheck = request.getParameter("isUseCheck");
		if(domain!=null && domain.startsWith("http://"))domain=domain.replace("http://", "");
		if(name==null || name.trim().equals("") || domain==null || domain.trim().equals("")){
			JSONUtil.print(response, Init.FAIL);
		}else{
			int i = service.update(id, name, domain, directory, isUseCheck);
			JSONUtil.print(response, i>0?Init.SUCCEED:Init.FAIL);
		}
	}
	@RequestMapping(value="domainIsExistWithSelf")
	public void domainIsExistWithSelf(HttpServletRequest request, HttpServletResponse response, Integer id){
		String domain = request.getParameter("domain");
		if(domain==null || domain.trim().equals("")){
			JSONUtil.print(response, Init.TRUE);
		}else{
			long i = service.countByDomainWithSelf(id, domain);
			JSONUtil.print(response, i>0?Init.TRUE:Init.FALSE);
		}
	}
	@RequestMapping(value="domainIsExist")
	public void domainIsExist(HttpServletRequest request, HttpServletResponse response){
		String domain = request.getParameter("domain");
		if(domain==null || domain.trim().equals("")){
			JSONUtil.print(response, Init.TRUE);
		}else{
			long i = service.countByDomain(domain);
			JSONUtil.print(response, i>0?Init.TRUE:Init.FALSE);
		}
	}
	@RequestMapping(value="directoryIsExistWithSelf")
	public void directoryIsExistWithSelf(HttpServletRequest request, HttpServletResponse response, Integer id){
		String domain = request.getParameter("directory");
		if(domain==null || domain.trim().equals("")){
			JSONUtil.print(response, Init.TRUE);
		}else{
			long i = service.countByDirectoryWithSelf(id, domain);
			JSONUtil.print(response, i>0?Init.TRUE:Init.FALSE);
		}
	}
	@RequestMapping(value="directoryIsExist")
	public void directoryIsExist(HttpServletRequest request, HttpServletResponse response){
		String domain = request.getParameter("directory");
		if(domain==null || domain.trim().equals("")){
			JSONUtil.print(response, Init.TRUE);
		}else{
			long i = service.countByDirectory(domain);
			JSONUtil.print(response, i>0?Init.TRUE:Init.FALSE);
		}
	}
	@RequestMapping(value="updateOpen")
	public void updateOpen(HttpServletRequest request, HttpServletResponse response, Integer id, Integer status){
		if(id==null || status==null){
			JSONUtil.print(response, Init.FAIL);
		}else{
			int i = service.updateOpen(id, status);
			JSONUtil.print(response, i>0?Init.SUCCEED:Init.FAIL);
		}
	}
	@RequestMapping("toSetSiteName")
	public String toSetSiteName(HttpServletRequest request, HttpServletResponse response,ModelMap modelMap){
		Integer siteId=User.getCurrentSiteId(request);
		if (siteId!=null&&siteId>0) {
			Map<String, Object> siteMap=this.service.load(siteId);
			if (siteMap!=null) {
				modelMap.put("name", siteMap.get("name"));
			}
		}
		return "site/site/setName";
	}
	@RequestMapping(value="updateSiteName")
	public void updateSiteName(HttpServletRequest request, HttpServletResponse response,String name){
		Integer siteId=User.getCurrentSiteId(request);
		String result=Init.FAIL;
		if(siteId!=null && siteId>0 && !StringUtil.isEmpty(name)){
			Map<String, Object> siteMap=new HashMap<String, Object>();
			siteMap.put("id", siteId);
			siteMap.put("name", name);
			int count= service.update(siteMap);
			result=count>0?Init.SUCCEED:Init.FAIL;
		}
		JSONUtil.print(response, result);
	}
}
