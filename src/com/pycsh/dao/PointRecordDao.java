package com.pycsh.dao;

import java.util.Map;

import com.base.vo.PageList;
import com.pycsh.model.PointRecord;

public interface PointRecordDao {
	/**
	 * 
	 * @param currentPage
	 * @param pageSize
	 * @param date 根据日期查
	 * @return
	 */
	PageList<PointRecord> getList(Integer currentPage,Integer pageSize,String date);
	/**
	 * 
	 * @param data
	 * @return 添加投票记录
	 */
	boolean addPointRecord(Map<String,Object> data);
	/**
	 * 
	 * @return 根据projectId获取对应的投票信息
	 */
	Map<String,Object> getPointRecordByProjectId(long projectId);
	/**
	 * 
	 * @param projectId 根据项目id统计票数
	 * @return
	 */
	int getPointCount(long projectId);
	/**
	 * 
	 * @param projectId 项目id
	 * @param userId 用户id
	 * @return 判断是否投过票了
	 */
	int getBolCount(long projectId,long userId);
	
}	
