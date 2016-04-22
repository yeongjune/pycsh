package com.pycsh.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.dao.SQLDao;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.pycsh.dao.DonateProjectDao;
import com.pycsh.dao.DonateRecordDao;
import com.pycsh.model.DonateRecord;
import com.pycsh.model.DonateRecordProject;
import com.pycsh.model.Project;
import com.pycsh.model.WeiXinUser;
import com.pycsh.service.DonateRecordProjectService;
import com.pycsh.util.SerialNoUtil;

@Service
public class DonateRecordProjectServiceImpl implements
		DonateRecordProjectService {

	@Autowired
	private DonateProjectDao dao;
	
	@Autowired
	private DonateRecordDao donateDao;
	
	@Autowired
	private SQLDao sqlDao;


	@Override
	public PageList findRecordByPage(Integer currentPage, Integer pageSize,
			Long projectId) {
		// TODO Auto-generated method stub
		return dao.findRecordByPage(currentPage, pageSize, projectId);
	}

	@Override
	public List<Map<String, Object>> findRecordStatistics(List<Long> idList) {
		// TODO Auto-generated method stub
		return dao.findRecordStatistics(idList);
	}

	@Override
	public void saveRecord(Long projectId, Long userId, Double money,
			Integer type,Long actId) {
		// TODO Auto-generated method stub
		Map<String,Object> record=new HashMap<String, Object>();
		record.put("userId", userId);
		record.put("money", money);
		record.put("lastMoney", 0);
		record.put("type", type);
		record.put("serialNo", SerialNoUtil.getSerialNo(type));
		record.put("state", DonateRecord.STATE_WAIT);
		Long donateId = donateDao.save(record);
		
		Map<String,Object> rp =new HashMap<String, Object>();
		rp.put("money", money);
		rp.put("donateId", donateId);
		rp.put("userId", userId);
		rp.put("projectId", projectId);
		rp.put("actId", actId);
		dao.saveRecord(rp);
	}

	@Override
	public PageList findProjectByMyPage(Integer currentPage, Integer pageSize,
			Long userId) {
		// TODO Auto-generated method stub
		return dao.findProjectByMyPage(currentPage, pageSize, userId);
	}

	@Override
	public List<Map<String, Object>> findMyRecord(Long projectId, Long userId) {
		// TODO Auto-generated method stub
		return dao.findMyRecord(projectId, userId);
	}

	@Override
	public List<Map<String, Object>> findMyRecordByType(Long userId) {
		// TODO Auto-generated method stub
		return dao.findMyRecordByType(userId);
	}
	
	
	@Override
	public List<Map<String, Object>> getList(String phone,String name,String startTime,String endTime) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageList getPageList(Integer currentPage, Integer pageSize,String phone,String projectName,String userName,String startTime,String endTime) {
		StringBuffer sql = new StringBuffer();
		List<String> paramList = new ArrayList<String>();
		sql.append("select d.id,ROUND(d.money,2) as money,d.projectId,rp.type,d.userId,DATE_FORMAT(d.createTime,\"%Y-%m-%d\") as createTime,p.name as pName,w.name as wName,w.loginName FROM "+DonateRecordProject.tableName+" d left join "+DonateRecord.tableName+" rp on(d.donateId=rp.id) ");
		sql.append(" left join "+Project.tableName+" p on d.projectId=p.id ");
		sql.append(" left join "+WeiXinUser.tableName+" w on w.id = d.userId where 1=1 ");

		if (!StringUtil.isEmpty(phone)) {
			sql.append(" AND p.phone like ?");
			paramList.add("%"+phone+"%");
		}
		if (!StringUtil.isEmpty(projectName)) {
			sql.append(" AND p.name like ?");
			paramList.add("%"+projectName+"%");
		}
		if (!StringUtil.isEmpty(startTime)) {
			sql.append(" AND createTime >= ?");
			paramList.add(startTime);
		}
		if (!StringUtil.isEmpty(endTime)) {
			sql.append(" AND createTime <= ?");
			paramList.add(endTime);
		}
		return sqlDao.getPageList(sql.toString(), currentPage, pageSize, paramList.toArray());
	}

	@Override
	public Map<String, Object> find(Long id) {
		StringBuffer sql = new StringBuffer();

	
		sql.append("select d.id,ROUND(d.money,2) as money,d.projectId,dr.type,d.userId,DATE_FORMAT(d.createTime,\"%Y-%m-%d\") as createTime,p.name as pName,w.name as wName,w.loginName FROM "+DonateRecordProject.tableName+" d ");

		sql.append(" left join "+Project.tableName+" p on d.projectId=p.id ");
		sql.append(" left join "+DonateRecord.tableName+" dr on d.donateId=dr.id ");
		sql.append(" left join "+WeiXinUser.tableName+" w on w.id = d.userId where d.id="+id);

		return sqlDao.queryForMap(sql.toString());
	}

	@Override
	public void saveRecordByDonate(Long donateId, Long projectId, Double money,Integer operatorId) {
		// TODO Auto-generated method stub
		
		Map<String,Object> record = donateDao.getDonateById(donateId);
		
		
		Map<String,Object> rp =new HashMap<String, Object>();
		rp.put("money", money);
		rp.put("donateId", donateId);
		rp.put("userId", record.get("userId"));
		rp.put("projectId", projectId);
		rp.put("operatorId", operatorId);
		dao.saveRecord(rp);
		

		donateDao.update((Double)record.get("lastMoney")-money, donateId);
	}

	@Override
	public void saveRecordTemp(Long userId, String serialNo, Double money,
			Integer type, Long projectId,Long actId,String name,String phone,String idcard,String exPhone) {
		// TODO Auto-generated method stub
		dao.saveRecordTemp(userId, serialNo, money, type, projectId,actId, name, phone, idcard, exPhone);
	}

	@Override
	public Map<String, Object> getRecordTempBySerialNo(String serialNo) {
		// TODO Auto-generated method stub
		return dao.getRecordTempBySerialNo(serialNo);
	}

	@Override
	public void updateRecordTemp(Map<String, Object> rt) {
		// TODO Auto-generated method stub
		dao.updateRecordTemp(rt);
	}

	@Override
	public List<Map<String, Object>> findRecordByProjectId(Long id) {
		// TODO Auto-generated method stub
		return dao.findRecordByProjectId(id);
	}


}
