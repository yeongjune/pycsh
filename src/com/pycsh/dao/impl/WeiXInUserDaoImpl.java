package com.pycsh.dao.impl;

import java.io.Serializable;
import java.util.*;

import com.pycsh.model.WeiXinUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.WeiXinUserDao;
import com.pycsh.model.WeiXinUser;

@Repository
public class WeiXInUserDaoImpl implements WeiXinUserDao {
	

	@Autowired
	private SQLDao bs;
	
	
	@Override
	public void saveUser(Map<String, Object> user) {
		// TODO Auto-generated method stub
		user.put("createTime", new Date());
		user.put("id", new Long(bs.save("pycsh_weixin_user", user).toString()));

	}

	@Override
	public int updateUser(Map<String, Object> user) {
		// TODO Auto-generated method stub
		return bs.updateMap("pycsh_weixin_user", "id", user);
	}

	@Override
	public Map<String, Object> getUserByLoginName(String loginName) {
		// TODO Auto-generated method stub
		String sql=" select * from pycsh_weixin_user where loginName = ? ";
		
		return bs.queryForMap(sql,loginName);
	}

	@Override
	public Map<String, Object> loginByPassword(String loginName,
			String password) {
		// TODO Auto-generated method stub
		String sql = " select * from pycsh_weixin_user where loginName = ? and password = ? ";
		return bs.queryForMap(sql,loginName,password);
	}

	@Override
	public PageList findUserByPage(Integer pageSize, Integer currentPage,
			String name, String loginName) {
		// TODO Auto-generated method stub
		List<Object> objList=new ArrayList<Object>();
		String sql=" select *,DATE_FORMAT(createTime,\"%Y-%m-%d\") as time from "+WeiXinUser.tableName+" where 1=1 ";
		if(name!=null&&name.trim().equals("")){
			sql+=" and name like ? ";
			objList.add("%"+name+"%");
		}
		
		if(loginName!=null&&!loginName.trim().equals("")){
			sql+=" and loginName like ? ";
			objList.add("%"+loginName+"%");
		} 
		return bs.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public Map<String, Object> getUserById(Long id) {
		// TODO Auto-generated method stub
		String sql = "select * from pycsh_weixin_user where id = ? ";
		return bs.queryForMap(sql,id);
	}

    @Override
    public Map<String, Object> getUserByPhoneOrOpenid(String phone, String openid) {
        String sql = "SELECT * FROM " + WeiXinUser.tableName + " u WHERE u.loginName = ? OR u.wxOpenId =? ";
        List<Map<String, Object>> list = bs.queryForList(sql, phone, openid);
        return list.size() > 0 ? list.get(0) : null;
    }

    @Override
    public int updateOpenid(String uOpenid, Long id) {
        Map<String, Object> params = new HashMap<String, Object>(2);
        params.put("id", id);
        params.put("wxOpenId", uOpenid);
        return bs.updateMap(WeiXinUser.tableName, "id", params);
    }

    @Override
    public int updatePhone(String phone, Long id) {
        Map<String, Object> params = new HashMap<String, Object>(2);
        params.put("id", id);
        params.put("loginName", phone);
        return bs.updateMap(WeiXinUser.tableName, "id", params);
    }

    @Override
    public Map<String, Object> getUserByOpenid(String openid) {
        String sql = "SELECT * FROM " + WeiXinUser.tableName + " u WHERE u.wxOpenId =? ";
        List<Map<String, Object>> list = bs.queryForList(sql, openid);
        return list.size() > 0 ? list.get(0) : null;
    }
}
