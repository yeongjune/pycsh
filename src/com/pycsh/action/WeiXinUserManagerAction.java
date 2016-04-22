package com.pycsh.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.config.Init;
import com.base.util.JSONUtil;
import com.base.vo.PageList;
import com.pycsh.service.WeiXinUserService;
@Controller
@RequestMapping("weixinUserManager")
public class WeiXinUserManagerAction {
	
	@Autowired
	private WeiXinUserService service;

	
	@RequestMapping(value="index")
	public String toUserList(HttpServletRequest request,ModelMap map)throws Exception{
		
		return "pycsh/weixinUser/index";
	}
	
	@RequestMapping(value="list")
	public void list(HttpServletRequest request,HttpServletResponse response,Integer pageSize,Integer currentPage,String loginName,String name)throws Exception{
		
		PageList pageList = service.findUserByPage(pageSize, currentPage, name, loginName);
		
		JSONUtil.printToHTML(response, pageList);
	}
	
	/**修改用户的状态
	 * @param response
	 * @param id
	 * @param flag
	 */
	@RequestMapping(value="updateStatus") 
	public void updateStatus(HttpServletResponse response,Long id,String flag){
		try {
			if (id != null && id != 0) {
				service.updateUserStatus(id, flag);
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
	 * 跳转到查看页面
	 * @return
	 */
	@RequestMapping("toView")
	public String toView(ModelMap map,Long id){
		map.put("user", service.getUserById(id));
		return "pycsh/weixinUser/view";
	}
}
