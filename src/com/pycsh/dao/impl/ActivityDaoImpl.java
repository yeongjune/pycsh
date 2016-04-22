package com.pycsh.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.ActivityDao;
import com.pycsh.model.Activity;
import com.pycsh.model.ActivityRecord;
import com.pycsh.model.ActivitySign;
import com.pycsh.model.DonateRecordTemp;
import com.pycsh.model.Project;
import com.pycsh.model.WeiXinUser;

@Repository
public class ActivityDaoImpl implements ActivityDao {
	
	
	@Autowired
	private SQLDao sqlDao;
	
	@Autowired
	private HQLDao bs;

	@Override
	public void saveActivity(Activity act) {
		// TODO Auto-generated method stub
		bs.save(act);
	}

	@Override
	public void updateActivity(Activity act) {
		// TODO Auto-generated method stub
		bs.update(act);
	}

	@Override
	public Activity getActivity(Long id) {
		// TODO Auto-generated method stub
		return bs.get(Activity.class, id);
	}

	@Override
	public PageList findActivityByPage(Integer currentPage, Integer pageSize,
			Integer isOpen,Integer status,String name) {
		// TODO Auto-generated method stub
		List<Object> objList= new ArrayList<Object>();
		String sql = " select * , DATE_FORMAT(startTime,\"%Y-%m-%d\") as startTimeFormat , DATE_FORMAT(endTime,\"%Y-%m-%d\") as endTimeFormat   from "+Activity.tableName+ " where isDelete !=1  " ;
		if(isOpen!=null){
			sql+=" and isOpen = ? ";
			objList.add(isOpen);
		}
		if(status!=null){
			sql+=" and status = ? ";
			objList.add(status);
		}
		if(name!=null&&!name.trim().equals("")){
			sql+=" and name like ? ";
			objList.add("%"+name+"%");
		}
		sql+=" order by id desc ";
		return sqlDao.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public void deleteActivity(Long id) {
		// TODO Auto-generated method stub
		String sql=" update "+Activity.tableName+" set isDelete =1 where id = ? ";
		sqlDao.update(sql,id);
	}

	@Override
	public void updateActivity(Map<String, Object> act) {
		// TODO Auto-generated method stub
		sqlDao.updateMap(Activity.tableName, "id", act);
	}

	@Override
	public void saveActivityRecord(ActivityRecord ar) {
		// TODO Auto-generated method stub
		bs.save(ar);
	}

	@Override
	public void updateActivityRecord(Map<String, Object> ar) {
		// TODO Auto-generated method stub
		sqlDao.updateMap(Activity.tableName, "id", ar);
	}

	@Override
	public List<Map<String, Object>> findActRecordList(Long userId, Long actId,
			Long projectId) {
		// TODO Auto-generated method stub
		String sql=" select * from "+ActivityRecord.tableName+" where 1=1 ";
		List<Object> objList =new ArrayList<Object>();
		if(userId!=null){
			
			sql+=" and userId  = ? ";
			objList.add(userId);
		}
		if(actId!=null){
			sql+=" and actId = ? ";
			objList.add(actId);
		}
		if(projectId!=null){
			sql+=" and projectId = ? ";
			objList.add(projectId);
		}
		
		return sqlDao.queryForList(sql,objList.toArray());
		
	}

	@Override
	public List<Map<String, Object>> findRecordStatistics(List<Long> idList) {
		// TODO Auto-generated method stub
		StringBuffer sqlb= new StringBuffer(" SELECT SUM(money) as money , COUNT(DISTINCT(idcard)) as userCount , actId FROM pycsh_activity_record where status=1 ");
		List<Object> objList=new ArrayList<Object>();
		if(idList!=null&&idList.size()>0){
			sqlb.append(" and actId in(0");
		}
		for(Long id:idList){
			sqlb.append(",?");
			objList.add(id);
		}
		if(idList!=null&&idList.size()>0){
			sqlb.append(") ");
		}
		sqlb.append(" group by actId ");
		return sqlDao.queryForList(sqlb.toString(),objList.toArray());
	
	}

	@Override
	public ActivityRecord findActRecord(Long recordId) {
		// TODO Auto-generated method stub
		String hql=" from "+ActivityRecord.modelName+" where recordId = ? ";
		return (ActivityRecord)bs.getObjectByHQL(hql, recordId.intValue());
	}

	@Override
	public List<ActivityRecord> findActRecord(Long actId, String idcard) {
		// TODO Auto-generated method stub
		String hql=" from "+ActivityRecord.modelName+" where status = 1 ";
		List<Object> objList =new ArrayList<Object>();
		if(actId!=null){
			hql+=" and actId = ? ";
			objList.add(actId);
		}
		if(idcard!=null&&!idcard.trim().equals("")){
			hql+=" and idcard = ? ";
			objList.add(idcard);
		}
		return bs.getListByHQL(hql, objList.toArray());
	}

	@Override
	public void updateActRecord(ActivityRecord ar) {
		// TODO Auto-generated method stub
		bs.update(ar);
	}

	@Override
	public PageList findRecordByPage(Integer currentPage, Integer pageSize,
			Long actId) {
		// TODO Auto-generated method stub
		String sql=" select r.*, DATE_FORMAT(r.createTime,\"%Y-%m-%d\") as createTimeFormat from "+ActivityRecord.tableName+" r  where r.actId = ? and r.status = 1 order by id desc  ";
		
		
		return sqlDao.getPageList(sql, currentPage, pageSize,actId);
	}

	@Override
	public Map<String, Object> getActivityByMap(Long id) {
		// TODO Auto-generated method stub
		String sql=" select * ,  DATE_FORMAT(startTime,\"%Y-%m-%d\")  as startTimeFormat , DATE_FORMAT(endTime,\"%Y-%m-%d\") as endTimeFormat from "+Activity.tableName+" where id = ? ";
		return sqlDao.queryForMap(sql,id);
	}

	@Override
	public PageList findActivityByMyPage(Integer currentPage, Integer pageSize,
			Long userId) {
		// TODO Auto-generated method stub
		String sql=" select r.code ,  r.money as sumMoney , r.name as recordName , p.* , DATE_FORMAT(p.startTime,\"%Y-%m-%d\") as startTimeFormat , DATE_FORMAT(p.endTime,\"%Y-%m-%d\") as endTimeFormat  from "+ActivityRecord.tableName+" r left join "+Activity.tableName+" p on(r.actId = p.id) where r.userId = ? and r.status = 1 ";
		return sqlDao.getPageList(sql, currentPage, pageSize,userId);
	}

	@Override
	public PageList findActRecordByPage(Integer currentPage, Integer pageSize,
			String name, String idcard, String phone, String actName, Long actId) {
		// TODO Auto-generated method stub
		String sql=" select r.* , a.name as actName from "+ActivityRecord.tableName+" r left join "+Activity.tableName+" a on(r.actId=a.id) where r.status = 1 ";
		List<Object> objList = new ArrayList<Object>();
		if(name!=null&&!name.trim().equals("")){
			sql+=" and r.name like ? ";
			objList.add("%"+name+"%");
		}
		if(idcard!=null&&!idcard.trim().equals("")){
			sql+=" and r.idcard like ? ";
			objList.add("%"+idcard+"%");
		}
		if(phone!=null&&!phone.trim().equals("")){
			sql+=" and r.phone like ? ";
			objList.add("%"+phone+"%");
		}
		if(actName!=null&&!actName.trim().equals("")){
			sql+=" and a.name like ? ";
			objList.add("%"+actName+"%");
		}
		if(actId!=null){
			sql+=" and  r.actId =  ? ";
			objList.add(actId);
		}
		sql+=" order by r.id desc ";
		return sqlDao.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public List<DonateRecordTemp> findRecordTempByIds(List<Long> idList) {
		// TODO Auto-generated method stub
		if(idList!=null&&idList.size()>0){
			
			String hql=" from "+DonateRecordTemp.modelName+" where id in(0";
			for(Long id:idList){
				hql+=",?";
			}
			hql+=")";
			return bs.getListByHQL(hql, idList.toArray());
		}else{
			
			return new ArrayList<DonateRecordTemp>();
		}
	}

	@Override
	public void saveSign(ActivitySign as) {
		// TODO Auto-generated method stub
		bs.save(as);
	}

	@Override
	public PageList findSignByPage(Integer currentPage, Integer pageSize,
			Long actId) {
		// TODO Auto-generated method stub
		String sql=" select s.* ,a.name ,u.loginName from "+ActivitySign.tableName+" s left join "+Activity.tableName+" a on(s.actId=a.id) left join "+WeiXinUser.tableName+" u on(s.openId = u.wxOpenId) where 1=1 ";
		List<Object> objList = new ArrayList<Object>();
		
		if(actId!=null){
			sql+=" and s.actId = ? ";
			objList.add(actId);
		}
		sql+=" order by id desc ";
		return sqlDao.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public ActivitySign getSign(Long id) {
		// TODO Auto-generated method stub
		return bs.get(ActivitySign.class, id);
	}

	
}
