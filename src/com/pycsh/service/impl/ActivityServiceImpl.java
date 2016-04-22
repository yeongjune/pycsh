package com.pycsh.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.vo.PageList;
import com.pycsh.dao.ActivityDao;
import com.pycsh.model.Activity;
import com.pycsh.model.ActivityRecord;
import com.pycsh.model.ActivitySign;
import com.pycsh.model.DonateRecordTemp;
import com.pycsh.service.ActivityService;


@Service
public class ActivityServiceImpl implements ActivityService {

	@Autowired
	private ActivityDao dao;
	
	@Override
	public void saveActivity(Activity act) {
		// TODO Auto-generated method stub
		dao.saveActivity(act);
	}

	@Override
	public void updateActivity(Activity act) {
		// TODO Auto-generated method stub
		dao.updateActivity(act);
	}

	@Override
	public void updateActivity(Map<String, Object> act) {
		// TODO Auto-generated method stub
		dao.updateActivity(act);
	}

	@Override
	public Activity getActivity(Long id) {
		// TODO Auto-generated method stub
		return dao.getActivity(id);
	}

	@Override
	public PageList findActivityByPage(Integer currentPage, Integer pageSize,
			Integer isOpen,Integer status,String name) {
		// TODO Auto-generated method stub
		return dao.findActivityByPage(currentPage, pageSize, isOpen,status,name);
	}

	@Override
	public void deleteActivity(Long id) {
		// TODO Auto-generated method stub
		dao.deleteActivity(id);
	}

	@Override
	public ActivityRecord findActRecord(Long recordId) {
		// TODO Auto-generated method stub
		
		return dao.findActRecord(recordId);
	}

	@Override
	public List<ActivityRecord> findActRecord(Long actId, String idcard) {
		// TODO Auto-generated method stub
		return dao.findActRecord(actId, idcard);
	}

	@Override
	public void updateActRecord(ActivityRecord ar) {
		// TODO Auto-generated method stub
		dao.updateActRecord(ar);
	}

	@Override
	public List<Map<String, Object>> findRecordStatistics(List<Long> idList) {
		// TODO Auto-generated method stub
		return dao.findRecordStatistics(idList);
	}

	@Override
	public PageList findRecordByPage(Integer currentPage, Integer pageSize,
			Long actId) {
		// TODO Auto-generated method stub
		return dao.findRecordByPage(currentPage, pageSize, actId);
	}

	@Override
	public Map<String, Object> getActivityByMap(Long id) {
		// TODO Auto-generated method stub
		return dao.getActivityByMap(id);
	}

	@Override
	public PageList findActivityByMyPage(Integer currentPage, Integer pageSize,
			Long userId) {
		// TODO Auto-generated method stub
		return dao.findActivityByMyPage(currentPage, pageSize, userId);
	}

	@Override
	public PageList findActRecordByPage(Integer currentPage, Integer pageSize,
			String name, String idcard, String phone, String actName,Long actId) {
		// TODO Auto-generated method stub
		
		return dao.findActRecordByPage(currentPage, pageSize, name, idcard, phone, actName, actId);
	}

	@Override
	public List<DonateRecordTemp> findRecordTempByIds(List<Long> idList) {
		// TODO Auto-generated method stub
		return dao.findRecordTempByIds(idList);
	}

	@Override
	public void saveSign(ActivitySign as) {
		// TODO Auto-generated method stub
		dao.saveSign(as);
	}

	@Override
	public PageList findSignByPage(Integer currentPage, Integer pageSize,
			Long actId) {
		// TODO Auto-generated method stub
		return dao.findSignByPage(currentPage, pageSize, actId);
	}

	@Override
	public ActivitySign getSign(Long id) {
		// TODO Auto-generated method stub
		return dao.getSign(id);
	}

}
