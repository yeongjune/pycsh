package com.pycsh.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.vo.PageList;
import com.pycsh.dao.PointRecordDao;
import com.pycsh.model.PointRecord;
import com.pycsh.service.PointRecordService;

@Service
public class PointRecordServiceImpl implements PointRecordService {
	@Autowired
	private PointRecordDao pointRecordDao;
	
	@Override
	public PageList<PointRecord> getList(Integer currentPage, Integer pageSize, String date) {
		
		return pointRecordDao.getList(currentPage, pageSize, date);
	}

	@Override
	public Map<String, Object> getPointRecordByProjectId(long projectId) {
		
		return pointRecordDao.getPointRecordByProjectId(projectId);
	}

	@Override
	public int getPointCount(long projectId) {
		
		return pointRecordDao.getPointCount(projectId);
	}

	@Override
	public boolean addPointRecord(long projectId, long userId) {
		Map<String,Object> data=new HashMap<String, Object>();
		data.put("createTime", new Date());
		data.put("userId", userId);
		data.put("charityProjectId",projectId);
		return pointRecordDao.addPointRecord(data);
	}

	@Override
	public int getBolCount(long projectId, long userId) {
		
		return pointRecordDao.getBolCount(projectId, userId);
	}

}
