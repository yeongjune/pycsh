package com.pycsh.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.base.vo.PageList;

public interface WeiXinUserService {

public void saveUser(Map<String,Object> user);
	
	public int updateUser(Map<String,Object> user);
	
	public Map<String,Object> getUserByLoginName(String loginName);
	
	public Map<String,Object> loginByPassword(String loginName,String password);
	
	public Map<String,Object> loginByCaptcha(String loginName ,String captcha ,HttpServletRequest request);
	
	public PageList findUserByPage(Integer pageSize , Integer currentPage ,String name, String loginName);

	public Map<String,Object> getUserById(Long id);

    /**
     * 根据用户手机号码和微信id获取用户
     * @param phone
     * @param openid
     * @return
     */
    Map<String,Object> getUserByPhoneOrOpenid(String phone, String openid);
	/**修改用户的状态（0=正常，1=禁用）
	 * @param id
	 * @param status
	 */
	void updateUserStatus(Long id,String status);
	
	
	public Map<String,Object> getSessionUser(HttpSession session);
	
	
	public Long getSessionUserId(HttpSession session);

    /**
     * 更新公众号id
     * @param uOpenid 公众号id
     * @param id 用户id
     * @return
     */
    int updateOpenid(String uOpenid, Long id);

    /**
     * 根据用户id更新绑定手机号码
     * @param phone
     * @param id
     * @return
     */
    int updatePhone(String phone, Long id);

    /**
     * 根据微信openid获取系统用户信息
     * @param openid
     * @return
     */
    Map<String,Object> getUserByOpenid(String openid);
}
