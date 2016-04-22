package com.pycsh.dao;

import java.util.List;
import java.util.Map;

import com.base.vo.PageList;

public interface DonateProjectDao {
	
	PageList findRecordByPage(Integer currentPage, Integer pageSize,Long projectId);
	
	List<Map<String,Object>> findRecordStatistics(List<Long> idList);
	
	Long saveRecord(Map<String,Object> record);
	
	PageList findProjectByMyPage(Integer currentPage,Integer pageSize,Long userId);
	
	List<Map<String, Object>> findMyRecord(Long projectId, Long userId);
	
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
