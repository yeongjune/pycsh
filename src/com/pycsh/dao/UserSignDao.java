package com.pycsh.dao;

import java.util.List;
import java.util.Map;

import com.base.vo.PageList;
import com.pycsh.model.CharityProject;
import com.pycsh.model.CharityRecord;
import com.pycsh.model.UserSign;
import com.pycsh.model.UserSignImg;
import com.pycsh.model.UserSignLog;

/**
 * 用户项目报名
 * @author Administrator
 *
 */
public interface UserSignDao {
	
	Long saveUserSign(UserSign us);
	
	UserSign getUserSign(Long id);
	
	Map<String,Object> getUserSignMap(Long id);
	
	void updateUserSign(Map<String,Object> us);
	
	Map<String,Object> getUserSignByUserId(Long userId);
	
	PageList<Map<String,Object>> findUserSignByPage(Integer currentPage,Integer pageSize,Integer status,String keyword);
	
	Long saveCharityProject(CharityProject cp);
	
	CharityProject getCharityProject(Long id);
	
	Map<String,Object> getCharityProjectByMap(Long id);
	
	void updateCharityProject(CharityProject cp);
	
	void updateCharityProjectMap(Map<String,Object> cp);
	
	PageList<Map<String,Object>> findCharityProjectByPage(Integer currentPage,Integer pageSize,Integer status,Long userId,Long userSignId,String name);
	
	Long saveUserSignImg(UserSignImg usi);
	
	void deleteUserSignImg(Long id,Long userId);
	
	List<Map<String,Object>> findUserSignImg(Long userId);
	
	void saveUserSignLog(UserSignLog usl);
	
	PageList<Map<String,Object>> findCharityProjectByPage(Integer currentPage,Integer pageSize, String name,Integer type);
	
	List<Map<String,Object>> getCharityMoney(List<Long> idList);
	
	List<Map<String,Object>> getCharityRecordList(Long id);
	
	PageList<Map<String,Object>> LoadCharityDonateRecord(Integer currentPage,Integer pageSize);
	
	PageList<Map<String,Object>> LoadCharityRecord(Integer currentPage,Integer pageSize,Long id);
	
	void saveCharityRecord(CharityRecord cr);
	
	CharityRecord getCharityRecord(Long id);
	
	void updateCharityRecord(CharityRecord cr);
}
