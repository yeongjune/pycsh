package com.pycsh.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.DonateProjectDao;
import com.pycsh.model.ActivityRecord;
import com.pycsh.model.DonateRecordTemp;
import com.pycsh.util.CaptchaUitl;

@Repository
public class DonateProjectDaoImpl implements DonateProjectDao {

	@Autowired
	private SQLDao sqlDao;
	
	@Autowired
	private HQLDao bs;
	
	
	@Override
	public PageList findRecordByPage(Integer currentPage, Integer pageSize,Long projectId) {
		// TODO Auto-generated method stub
		String sql=" select r.*, u.loginName , u.name  , DATE_FORMAT(r.createTime,\"%Y-%m-%d\") as createTimeFormat from pycsh_donate_record_project r , pycsh_weixin_user u where r.projectId = ? and u.id=r.userId order by id desc  ";
		
		
		return sqlDao.getPageList(sql, currentPage, pageSize,projectId);
	}

	@Override
	public List<Map<String, Object>> findRecordStatistics(List<Long> idList) {
		// TODO Auto-generated method stub
		StringBuffer sqlb= new StringBuffer(" SELECT SUM(money) as money , COUNT(DISTINCT(userId)) as userCount , projectId FROM pycsh_donate_record_project where 1=1  ");
		List<Object> objList=new ArrayList<Object>();
		if(idList!=null&&idList.size()>0){
			sqlb.append(" and projectId in(0");
		}
		for(Long id:idList){
			sqlb.append(",?");
			objList.add(id);
		}
		if(idList!=null&&idList.size()>0){
			sqlb.append(") ");
		}
		sqlb.append(" group by projectId ");
		return sqlDao.queryForList(sqlb.toString(),objList.toArray());
	}

	@Override
	public Long saveRecord(Map<String, Object> record) {
		// TODO Auto-generated method stub
		record.put("createTime", new Date());
		return new Long(sqlDao.save("pycsh_donate_record_project", record).toString());
		
	}

	@Override
	public PageList findProjectByMyPage(Integer currentPage, Integer pageSize,
			Long userId) {
		// TODO Auto-generated method stub
		String sql=" select sum(r.money) as sumMoney , p.* from pycsh_donate_record_project r left join pycsh_project p on(r.projectId = p.id) where r.userId = ? group by r.projectId ";
		return sqlDao.getPageList(sql, currentPage, pageSize,userId);
	}

	@Override
	public List<Map<String, Object>> findMyRecord(Long projectId, Long userId) {
		// TODO Auto-generated method stub
		
		if(projectId!=null){
			
			String sql = " select * , DATE_FORMAT(createTime,\"%Y-%m-%d\") as createTimeFormat from pycsh_donate_record_project where projectId = ? and userId = ? ";

			return sqlDao.queryForList(sql,projectId,userId);
		}else{
			String sql = " select * from pycsh_donate_record_project where  userId = ? group by projectId ";

			return sqlDao.queryForList(sql,userId);
		}
		
	}

	@Override
	public List<Map<String, Object>> findMyRecordByType(Long userId) {
		// TODO Auto-generated method stub
		String sql=" select sum(r.money) as sumMoney , t.name from pycsh_donate_record_project r left join pycsh_project p on(r.projectId = p.id) left join pycsh_project_type t on(p.type1=t.id) where r.userId = ? group by r.projectId ";
		return sqlDao.queryForList(sql,userId);
	}

	@Override
	public void saveRecordTemp(Long userId, String serialNo, Double money,
			Integer type, Long projectId,Long actId,String name,String phone,String idcard,String exPhone) {
		// TODO Auto-generated method stub
		Map<String,Object> rt=new HashMap<String, Object>();
		rt.put("userId", userId);
		rt.put("serialNo", serialNo);
		rt.put("money", money);
		rt.put("type", type);
		rt.put("projectId", projectId);
		rt.put("createTime", new Date());
		
		rt.put("createTime", new Date());
		rt.put("state",0);
		if(actId!=null){
			rt.put("actId", actId);
		}
		Integer recordId =(Integer)sqlDao.save(DonateRecordTemp.tableName, rt);
		
		if(actId!=null){
			SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMdd");
			ActivityRecord ar =new ActivityRecord();
			ar.setActId(actId);
			ar.setCreateTime(new Date());
			ar.setMoney(money);
			ar.setRecordId(recordId);
			ar.setUserId(userId);
			ar.setName(name);
			ar.setPhone(phone);
			ar.setExPhone(exPhone);
			ar.setIdcard(idcard);
			String tmpCode=CaptchaUitl.getCaptcha(8-recordId.toString().length());
			ar.setCode(sdf.format(new Date())+recordId.toString()+tmpCode);
	
			bs.save(ar);
		}
		
	}

	@Override
	public Map<String, Object> getRecordTempBySerialNo(String serialNo) {
		// TODO Auto-generated method stub
		return sqlDao.queryForMap(" select * from "+DonateRecordTemp.tableName+" where serialNo = ? ",serialNo);
	}

	@Override
	public void updateRecordTemp(Map<String, Object> rt) {
		// TODO Auto-generated method stub
		sqlDao.updateMap(DonateRecordTemp.tableName, "id", rt);
	}

	@Override
	public List<Map<String, Object>> findRecordByProjectId(Long id) {
		// TODO Auto-generated method stub
		String sql= " select rp.* , r. ";
		return null;
	}
}
