package com.pycsh.dao;

import java.util.List;
import java.util.Map;

import com.base.vo.PageList;
import com.pycsh.model.Activity;
import com.pycsh.model.ActivityRecord;
import com.pycsh.model.ActivitySign;
import com.pycsh.model.DonateRecordTemp;
import com.pycsh.model.Project;

public interface ActivityDao {
	
	void saveActivity(Activity act);
	
	void updateActivity(Activity act);
	
	void updateActivity(Map<String,Object> act);
	
	Activity getActivity(Long id);
	
	PageList findActivityByPage(Integer currentPage,Integer pageSize,Integer isOpen,Integer status,String name);
	
	void deleteActivity(Long id);
	
	void saveActivityRecord(ActivityRecord ar);
	
	void updateActivityRecord(Map<String,Object> ar);
	
	List<Map<String,Object>> findActRecordList(Long userId,Long actId,Long projectId);
	
	List<Map<String,Object>> findRecordStatistics(List<Long> idList);
	
	ActivityRecord findActRecord(Long recordId);
	
	List<ActivityRecord> findActRecord(Long actId,String idcard);
	
	void updateActRecord(ActivityRecord ar);
	
	/**
	 * 捐款用户记录分页查询
	 * @param currentPage
	 * @param pageSize
	 * @param projectId
	 * @return
	 */
	PageList findRecordByPage(Integer currentPage, Integer pageSize,Long actId);
	
	Map<String,Object> getActivityByMap(Long id);
	
	/**
	 * 我报名的活动分页查询
	 * @param currentPage
	 * @param pageSize
	 * @param userId
	 * @return
	 */
	PageList findActivityByMyPage(Integer currentPage,Integer pageSize,Long userId);
	
	PageList findActRecordByPage(Integer currentPage, Integer pageSize,
			String name, String idcard, String phone, String actName, Long actId);
	
	List<DonateRecordTemp> findRecordTempByIds(List<Long> idList);
	
	
	void saveSign(ActivitySign as);
	
	PageList findSignByPage(Integer currentPage,Integer pageSize,Long actId);
	
	ActivitySign getSign(Long id);
	
}
