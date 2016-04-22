package com.pycsh.service.impl;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.WeiXinUserDao;
import com.pycsh.model.WeiXinUser;
import com.pycsh.service.WeiXinUserService;

@Service
public class WeiXinUserServiceImpl implements WeiXinUserService {
	
	@Autowired
	private WeiXinUserDao dao;
	
	@Autowired
	private SQLDao sqlDao;
	
	@Override
	public void saveUser(Map<String, Object> user) {
		// TODO Auto-generated method stub
		dao.saveUser(user);
	}

	@Override
	public int updateUser(Map<String, Object> user) {
		// TODO Auto-generated method stub
		return dao.updateUser(user);
	}

	@Override
	public Map<String, Object> getUserByLoginName(String loginName) {
		// TODO Auto-generated method stub
		return dao.getUserByLoginName(loginName);
	}

	@Override
	public Map<String, Object> loginByPassword(String loginName,
			String password) {
		// TODO Auto-generated method stub
		return dao.loginByPassword(loginName, password);
	}

	@Override
	public Map<String, Object> loginByCaptcha(String loginName, String captcha,
			HttpServletRequest request) {
		// TODO Auto-generated method stub
		String sessionCaptcha = (String)request.getSession().getAttribute("captcha");
		Date captchaTime = (Date)request.getSession().getAttribute("captchaTime");
		if(captchaTime!=null&&captchaTime.getTime()>(new Date().getTime()-600000)&&captcha!=null&&captcha.equals(sessionCaptcha)){
			
			return dao.getUserByLoginName(loginName);
		}
		
		return null;
	}

	@Override
	public PageList findUserByPage(Integer pageSize, Integer currentPage,
			String name, String loginName) {
		// TODO Auto-generated method stub
		return dao.findUserByPage(pageSize, currentPage, name, loginName);
	}

	@Override
	public Map<String, Object> getUserById(Long id) {
		// TODO Auto-generated method stub
		return dao.getUserById(id);
	}

    @Override
    public Map<String, Object> getUserByPhoneOrOpenid(String phone, String openid) {
        return dao.getUserByPhoneOrOpenid(phone, openid);
    }

    @Override
	public void updateUserStatus(Long id, String status) {
		String sql = "UPDATE "+WeiXinUser.tableName+" SET status = "+status+" WHERE id = "+id;
		sqlDao.execute(sql);
	}

	public WeiXinUserDao getDao() {
		return dao;
	}

	public void setDao(WeiXinUserDao dao) {
		this.dao = dao;
	}

	public SQLDao getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(SQLDao sqlDao) {
		this.sqlDao = sqlDao;
	}
	
	@Override
	public Map<String, Object> getSessionUser(HttpSession session) {
		// TODO Auto-generated method stub
		//session.setAttribute("weixinUser", getUserById(1l));
		Map<String,Object> user= (Map<String,Object>)session.getAttribute("weixinUser");
		return user;


		
	}

	@Override
	public Long getSessionUserId(HttpSession session) {
		// TODO Auto-generated method stub
		Map<String,Object> user = getSessionUser(session);
		if(user!=null){
			
			return (Long)user.get("id");
		}else{
			return null;
		}
		
	}

    @Override
    public int updateOpenid(String uOpenid, Long id) {
        return dao.updateOpenid(uOpenid, id);
    }

    @Override
    public int updatePhone(String phone, Long id) {
        return dao.updatePhone(phone, id);
    }

    @Override
    public Map<String, Object> getUserByOpenid(String openid) {
        return dao.getUserByOpenid(openid);
    }
}
