package com.pycsh.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.base.vo.PageList;

public interface DonateRecordProjectService {
	
	List<Map<String, Object>> getList(String phone,String name,String startTime,String endTime);
	
	PageList getPageList(Integer currentPage, Integer pageSize,String phone,String projectName,String userName,String startTime,String endTime);
	
	Map<String, Object> find(Long id);

	/**
	 * 捐款用户记录分页查询
	 * @param currentPage
	 * @param pageSize
	 * @param projectId
	 * @return
	 */
	PageList findRecordByPage(Integer currentPage, Integer pageSize,Long projectId);
	
	/**
	 * 捐款记录统计
	 * @param idList
	 * @return
	 */
	List<Map<String, Object>> findRecordStatistics(List<Long> idList);
	
	/**
	 * 保存项目捐款记录
	 * @param projectId
	 * @param userId
	 * @param money
	 * @param type
	 */
	void saveRecord(Long projectId,Long userId,Double money,Integer type,Long actId);
	

	
	/**
	 * 从捐赠库中划分捐款到项目
	 * @param donateId
	 * @param projectId
	 * @param money
	 */
	void saveRecordByDonate(Long donateId,Long projectId,Double money,Integer operatorId);
	
	/**
	 * 我捐款的项目分页查询
	 * @param currentPage
	 * @param pageSize
	 * @param userId
	 * @return
	 */
	PageList findProjectByMyPage(Integer currentPage,Integer pageSize,Long userId);

	/**
	 * 我捐款的项目 详细记录
	 * @param projectId
	 * @param userId
	 * @return
	 */
	List<Map<String,Object>> findMyRecord(Long projectId,Long userId);
	
	/**
	 * 我的捐款分类统计
	 * @param userId
	 * @return
	 */
	List<Map<String,Object>> findMyRecordByType(Long userId);
	
	void saveRecordTemp(Long userId,String serialNo,Double money,Integer type,Long projectId,Long actId,String name,String phone,String idcard,String exPhone);
	
	Map<String,Object> getRecordTempBySerialNo(String serialNo);
	
	void updateRecordTemp(Map<String,Object> rt);
	
	/**
	 * 根据项目id 查找捐赠记录
	 * @param id
	 * @return
	 */
	List<Map<String,Object>> findRecordByProjectId(Long id);
	
}
