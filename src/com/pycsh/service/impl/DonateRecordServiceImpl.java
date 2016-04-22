package com.pycsh.service.impl;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.pycsh.dao.DonateRecordDao;
import com.pycsh.dao.ProjectDao;
import com.pycsh.model.DonateRecord;
import com.pycsh.model.Project;
import com.pycsh.model.WeiXinUser;
import com.pycsh.service.DonateRecordService;
import com.pycsh.util.SerialNoUtil;

@Service
public class DonateRecordServiceImpl implements DonateRecordService{


	@Autowired
	private DonateRecordDao dao;

	@Override
	public void saveRecord(Long userId, Double money, Integer type) {
		// TODO Auto-generated method stub
		Map<String,Object> record=new HashMap<String, Object>();
		record.put("userId", userId);
		record.put("money", money);
		record.put("lastMoney", money);
		record.put("type", type);
		record.put("serialNo", SerialNoUtil.getSerialNo(type));
		record.put("state", DonateRecord.STATE_WAIT);
		dao.save(record);
	}

	@Override
	public void updateByCallBack(String transactionId,String serialNo, Double money, Date endTime,
			Integer state) {
		// TODO Auto-generated method stub
		Map<String,Object> record=dao.getDonateBySerialNo(serialNo);
		record.put("money", money);
		record.put("endTime", endTime);
		record.put("state", state);
		record.put("transactionId", transactionId);
		dao.update(record);
		
		
	}

	@Override
	public Map<String, Object> getRecord(Long id) {
		// TODO Auto-generated method stub
		return dao.getDonateById(id);
	}

	@Override
	public PageList findRecordByPage(Long userId, Integer currentPage,
			Integer pageSize) {
		// TODO Auto-generated method stub
		return dao.findDonateByPage(currentPage, pageSize, userId);
	}

	@Override
	public List<Map<String, Object>> findRecordProject(Long id) {
		// TODO Auto-generated method stub
		return dao.findDonateRecordList(id);
	}

	@Override
	public Map<String, Object> getDonateSum() {
		// TODO Auto-generated method stub
		return dao.getDonateSum();
	}

	
	
}
