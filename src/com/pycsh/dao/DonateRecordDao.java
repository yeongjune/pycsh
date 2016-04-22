package com.pycsh.dao;

import java.util.List;
import java.util.Map;

import com.base.vo.PageList;

public interface DonateRecordDao {

	Long save(Map<String,Object> record);
	
	void update(Map<String,Object> record);
	
	void update(Double lastMoney ,Long id);
	
	Map<String,Object> getDonateById(Long id);
	
	Map<String,Object> getDonateBySerialNo(String serialNo);
	
	PageList findDonateByPage(Integer currentPage,Integer pageSize,Long userId);
	
	List<Map<String,Object>> findDonateRecordList(Long id);
	
	Map<String,Object> getDonateSum();
	
	List<Map<String,Object>> findRecordByProjectId(Long id);
}
