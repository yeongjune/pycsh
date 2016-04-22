package com.pycshFront.action;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pycsh.model.Contribute;
import com.pycsh.service.ContributeService;
import com.site.service.ImageService;

@Controller
@RequestMapping("contributeFront")
public class ContributeFrontAction {
	
	@Autowired
	private ContributeService service;
	
	@Autowired
	private ImageService imageService;
	

	
	@RequestMapping(value="toAdd")
	public String toAdd(HttpServletResponse response,HttpServletRequest request)throws Exception{
		
		return "pycshFront/contribute";
	}
	
	
	@RequestMapping(value="save")
	public void save(HttpServletRequest request,HttpServletResponse response,Contribute con,String attachmentIds)throws Exception{
		con.setCreateTime(new Date());
		service.save(con);
	
		imageService.updateImageArticleId(con.getId().intValue(), attachmentIds);
		response.getWriter().print("ok");
	}
	


}
