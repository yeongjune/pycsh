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

import net.sf.json.JSONArray;

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
import com.pycsh.model.ProjectType;
import com.pycsh.service.ProjectTypeService;
import com.pycsh.vo.ProjectTypeVo;

@Controller
@RequestMapping("projectType")
public class ProjectTypeAction {

	@Autowired
	private ProjectTypeService projectTypeService;
	
	
	/**
	 * 获取列表数据
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("list")
	public void list(HttpServletRequest request, HttpServletResponse response,String pId,String category){
		try {
			JSONUtil.print(response, projectTypeService.getList(pId, category));
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	/**
	 * 进入项目类型选择列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("projectTypeSelect")
	public String projectTypeSelect(ModelMap map,HttpServletRequest request, HttpServletResponse response,String pId,String category,ProjectTypeVo vo){
		List<Map<String,Object>> list = projectTypeService.getList(pId, category);
		JSONArray jsonArray = JSONArray.fromObject( list );  
		map.put("list", list);
		map.put("jsonList", jsonArray);
		map.put("id1", vo.getId1());
		map.put("name1", vo.getName1());
		map.put("defaultValue1", vo.getDefaultValue1());
		map.put("id2", vo.getId2());
		map.put("name2", vo.getName2());
		map.put("defaultValue2", vo.getDefaultValue2());
		return "../../common/selectProjectType";
	}
	
	/**
	 * 跳转到首页
	 * @return
	 */
	@RequestMapping("index")
	public String index(ModelMap map){
		return "pycsh/projectType/index";
	}
	/**
	 * 跳转到新增页面
	 * @return
	 */
	@RequestMapping("add")
	public String add(ModelMap map){
		map.put("typeList", projectTypeService.getList("0", null));
		return "pycsh/projectType/add";
	}
	/**
	 * 跳转到修改页面
	 * @return
	 */
	@RequestMapping("toEdit")
	public String toEdit(ModelMap map,Long id){
		map.put("project", projectTypeService.find(id));
		return "pycsh/projectType/edit";
	}
	/**
	 * 跳转到查看页面
	 * @return
	 */
	@RequestMapping("toView")
	public String toView(ModelMap map,Long id){
		map.put("project", projectTypeService.find(id));
		return "pycsh/projectType/view";
	}
	/**
	 * 获取列表数据
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getList")
	public void getList(HttpServletRequest request, HttpServletResponse response, Integer currentPage, Integer pageSize,
			String name,String startTime,String endTime,String status,String type1,String type2){
		try {
			currentPage = Init.getCurrentPage(currentPage);
			pageSize = Init.getPageSize(pageSize);
			PageList pageList = projectTypeService.getPageList(currentPage, pageSize, name, startTime, endTime, status, type1, type2);
			//pageList.setList(DataUtil.deleteListMapByKey((List<Map<String, Object>>) pageList.getList(), "content")) ;
			JSONUtil.printToHTML(response, pageList);
		} catch (Exception e) {
			JSONUtil.print(response, Init.FAIL);
			e.printStackTrace();
		}
	}
	
	@RequestMapping("save")
	public void save(HttpServletRequest request, HttpServletResponse response, String name,String pId,String category,Integer sort){
		try {
			if("".equals(pId)){
				pId = "0";
			}
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("category", category);
			map.put("name", name);
			map.put("pId", pId);
			map.put("sort", sort);
			map.put("isDelete", "0");
			Serializable id = projectTypeService.save(map);
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
	public void update(HttpServletRequest request, HttpServletResponse response,Long id, String name,String pId,Integer sort){
		try {
			Map<String, Object> map = projectTypeService.find(id);
			map.put("name", name);
			map.put("pId", pId);
			map.put("sort", sort);
			map.remove("pName");
			projectTypeService.update(map);
			JSONUtil.print(response, Init.SUCCEED);
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
	public void delete(HttpServletResponse response,Integer id){
		try {
			if (id!=null&&id!=0) {
				projectTypeService.delete(id);
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
