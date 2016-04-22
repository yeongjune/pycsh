package com.pycsh.dao;

import java.util.Map;

import com.base.vo.PageList;

public interface WeiXinUserDao {
	
	public void saveUser(Map<String,Object> user);
	
	public int updateUser(Map<String,Object> user);
	
	public Map<String,Object> getUserByLoginName(String loginName);
	
	public Map<String,Object> loginByPassword(String loginName,String password);
	
	public PageList findUserByPage(Integer pageSize , Integer currentPage ,String name, String loginName);

	public Map<String,Object> getUserById(Long id);

    Map<String,Object> getUserByPhoneOrOpenid(String phone, String openid);

    /**
     * 更新公众号id
     * @param uOpenid 公众号id
     * @param id 用户id
     * @return
     */
    int updateOpenid(String uOpenid, Long id);

    /**
     * 根据用户id更新手机号码
     * @param phone
     * @param id
     * @return
     */
    int updatePhone(String phone, Long id);

    /**
     * 根据微信的openid获取用户信息
     * @param openid
     * @return
     */
    Map<String,Object> getUserByOpenid(String openid);
}
