package com.pycsh.service;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.base.vo.PageList;

public interface DonateRecordService {
	

	/**
	 * 保存捐款记录
	 * @param projectId
	 * @param userId
	 * @param money
	 * @param type
	 */
	void saveRecord(Long userId,Double money,Integer type);
	
	void updateByCallBack(String transactionId,String serialNo,Double money,Date endTime,Integer state);
	
	Map<String,Object> getRecord(Long id);
	
	PageList findRecordByPage(Long userId,Integer currentPage,Integer pageSize);
	
	/**
	 * 查询捐款记录 分配的项目
	 * @param id
	 * @return
	 */
	List<Map<String,Object>> findRecordProject(Long id);
	
	Map<String,Object> getDonateSum();
	

}
