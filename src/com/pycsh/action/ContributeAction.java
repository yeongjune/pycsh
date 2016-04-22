package com.pycsh.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.util.JSONUtil;
import com.base.vo.PageList;
import com.pycsh.model.Contribute;
import com.pycsh.service.ContributeService;
import com.site.service.ImageService;



@Controller
@RequestMapping("contribute")
public class ContributeAction {
	
	@Autowired
	private ContributeService service;
	
	@Autowired
	private ImageService imageService;
	
	@RequestMapping(value="toList")
	public String toList(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
		return "pycsh/contribute/index";
	}
	
	
	@RequestMapping(value="loadList")
	public void loadList(HttpServletRequest request,HttpServletResponse response,Integer currentPage, Integer pageSize,
			String title, String author, String phone,Integer status )throws Exception{
		
		PageList pageList = service.findContributeByPage(currentPage, pageSize, title, author, phone, status);
		JSONUtil.printToHTML(response, pageList);
		
	}
	
	@RequestMapping(value="toView")
	public String toView(HttpServletRequest request,HttpServletResponse response,Long id,ModelMap map)throws Exception{
		Contribute con = service.getContribute(id);
		map.put("con", con);
		map.put("fileList", imageService.find(id.intValue(), 3, null, null));
		Map<String,Object> tmp=new HashMap<String, Object>();
		tmp.put("id", id);
		tmp.put("status", 1);
		service.update(tmp);
		return "pycsh/contribute/view";
	}

	
	@RequestMapping(value="updateContributeStatus")
	public void updateContributeStatus(HttpServletRequest request,HttpServletResponse response,Long id,Integer status)throws Exception{
		Map<String,Object> con=new HashMap<String, Object>();
		con.put("id", id);
		con.put("status", status);
		service.update(con);
		response.getWriter().print("ok");
		
	}
	
	@RequestMapping(value="delete")
	public void delete(HttpServletRequest request,HttpServletResponse response,Long id)throws Exception{
		
		service.deleteContribute(id);
		response.getWriter().print("ok");
	}
	
	
	
}
