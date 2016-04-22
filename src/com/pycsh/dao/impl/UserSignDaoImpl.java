package com.pycsh.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.UserSignDao;
import com.pycsh.model.CharityProject;
import com.pycsh.model.CharityRecord;
import com.pycsh.model.DonateRecordCharityProject;
import com.pycsh.model.ProjectType;
import com.pycsh.model.UserSign;
import com.pycsh.model.UserSignImg;
import com.pycsh.model.UserSignLog;
import com.pycsh.model.WeiXinUser;
import com.tencent.WXPay;

@Repository
public class UserSignDaoImpl implements UserSignDao {
	
	@Autowired
	private SQLDao sqlDao;
	
	@Autowired
	private HQLDao hqlDao;

	@Override
	public Long saveUserSign(UserSign us) {
		// TODO Auto-generated method stub
		String sql=" delete from "+UserSign.tableName+" where userId = ? ";
		sqlDao.update(sql,us.getUserId());
		us.setCreateTime(new Date());
		
		return (Long)hqlDao.save(us);
	}

	@Override
	public UserSign getUserSign(Long id) {
		// TODO Auto-generated method stub
		
		return (UserSign)hqlDao.get(UserSign.class, id);
	}

	@Override
	public Map<String, Object> getUserSignMap(Long id) {
		// TODO Auto-generated method stub
		String sql=" select * from "+UserSign.tableName+" where id =  ? " ;
		
		return sqlDao.queryForMap(sql,id);
	}

	@Override
	public void updateUserSign(Map<String, Object> us) {
		// TODO Auto-generated method stub
		sqlDao.updateMap(UserSign.tableName, us, "id");
	}

	@Override
	public Map<String, Object> getUserSignByUserId(Long userId) {
		// TODO Auto-generated method stub
		String sql=" select * from "+UserSign.tableName+" where userId = ? ";
		return sqlDao.queryForMap(sql,userId);
	}

	@Override
	public PageList<Map<String, Object>> findUserSignByPage(
			Integer currentPage, Integer pageSize, Integer status,String keyword) {
		// TODO Auto-generated method stub
		
		String sql=" select us.* ,u.name , u.loginName from "+UserSign.tableName+" us left join "+WeiXinUser.tableName+" u on(us.userId=u.id) where 1=1 ";
		List<Object> objList =new ArrayList<Object>();
		if(status!=null){
			
			sql+=" and us.status = ? ";
			objList.add(status);
		}
		if(keyword!=null&&!keyword.trim().equals("")){
			sql+=" and (us.company like ? or us.corporation like ? or us.contact like ? or us.contactPhone like ? )";
			objList.add("%"+keyword+"%");
			objList.add("%"+keyword+"%");
			objList.add("%"+keyword+"%");
			objList.add("%"+keyword+"%");
		}
		sql+=" order by us.id desc ";
		return sqlDao.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public Long saveCharityProject(CharityProject cp) {
		// TODO Auto-generated method stub
		cp.setCreateTime(new Date());
		return (Long)hqlDao.save(cp);
	}

	@Override
	public CharityProject getCharityProject(Long id) {
		// TODO Auto-generated method stub
		
		return hqlDao.get(CharityProject.class, id);
	}

	@Override
	public Map<String, Object> getCharityProjectByMap(Long id) {
		// TODO Auto-generated method stub
		String sql =" select cp.* , t.name as typeName from "+CharityProject.tableName+" cp left join "+ProjectType.tableName+" t on(cp.type=t.id) where cp.id = ? ";
		return sqlDao.queryForMap(sql,id);
	}

	@Override
	public void updateCharityProjectMap(Map<String, Object> cp) {
		// TODO Auto-generated method stub
		sqlDao.updateMap(CharityProject.tableName, cp, "id");
	}
	
	@Override
	public void updateCharityProject(CharityProject cp) {
		// TODO Auto-generated method stub
		hqlDao.update(cp);
	}
	
	

	@Override
	public PageList<Map<String, Object>> findCharityProjectByPage(
			Integer currentPage, Integer pageSize, Integer status, Long userId,
			Long userSignId, String name) {
		// TODO Auto-generated method stub
		String sql=" select c.*,  us.company ,u.name as userName , u.loginName ,DATE_FORMAT(c.startTime,\"%Y-%m-%d\") as startTimeFormat , DATE_FORMAT(c.endTime,\"%Y-%m-%d\") as endTimeFormat ,  DATE_FORMAT(c.createTime,\"%Y-%m-%d\") as createTimeFormat , t.name as typeName from "+CharityProject.tableName+" c  left join "+UserSign.tableName+" us on(c.userSignId = us.id) left join "+WeiXinUser.tableName+" u on(c.userId=u.id) left join pycsh_project_type t on(t.id=c.type) where 1=1 ";
		List<Object> objList =new ArrayList<Object>();
		if(status!=null){
			
			sql+=" and c.status = ? ";
			objList.add(status);
		}
		if(userId==null&&status==null){
			sql+=" and c.status != 1 ";
		}
		if(userId!=null){
			
			sql+=" and c.userId = ? ";
			objList.add(userId);
		}
		if(userId!=null){
			
			sql+=" and c.userId = ? ";
			objList.add(userId);
		}
		
		if(name!=null&&!name.trim().equals("")){
			
			sql+=" and c.name = ? ";
			objList.add(name);
		}
		
		sql+=" order by c.id desc ";
		return sqlDao.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public Long saveUserSignImg(UserSignImg usi) {
		// TODO Auto-generated method stub
		String sql=" select * from "+UserSignImg.tableName+" where userId = ? ";
		List list =sqlDao.queryForList(sql,usi.getUserId());
		if(list.size()<5){
			usi.setCreateTime(new Date());
			return (Long)hqlDao.save(usi);
		}else{
			return null;
		}
		
	}

	@Override
	public void deleteUserSignImg(Long id, Long userId) {
		// TODO Auto-generated method stub
		if(id==null){
			String sql =" delete from "+UserSignImg.tableName+" where userId = ? ";
			sqlDao.update(sql,userId);
		}else{
			String sql =" delete from "+UserSignImg.tableName+" where id = ? and userId = ? ";
			sqlDao.update(sql,id,userId);
		}
		
	}

	@Override
	public List<Map<String, Object>> findUserSignImg(Long userId) {
		// TODO Auto-generated method stub
		String sql=" select * from "+UserSignImg.tableName+" where userId = ? ";
		return sqlDao.queryForList(sql,userId);
	}

	@Override
	public void saveUserSignLog(UserSignLog usl) {
		// TODO Auto-generated method stub
		usl.setCreateTime(new Date());
		hqlDao.save(usl);
	}

	@Override
	public PageList<Map<String, Object>> findCharityProjectByPage(
			Integer currentPage, Integer pageSize, String name,Integer type) {
		// TODO Auto-generated method stub
		String sql=" select cp.* , us.company ,DATE_FORMAT(cp.startTime,\"%Y-%m-%d\") as startTimeFormat , DATE_FORMAT(cp.endTime,\"%Y-%m-%d\") as endTimeFormat from "+CharityProject.tableName+" cp left join "+UserSign.tableName+" us on(cp.userId=us.userId)  where cp.checked = 1 and cp.isOpen = 1 ";
		List<Object> objList =new ArrayList<Object>();
		if(name!=null&&!name.trim().equals("")){
			sql+=" and cp.name like = ? ";
			objList.add("%"+name+"%");
		}
		if(type!=null){
			sql+=" and cp.type = ? ";
			objList.add(type);
		}
		sql+=" order by cp.id desc ";
		return sqlDao.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public List<Map<String, Object>> getCharityMoney(List<Long> idList) {
		// TODO Auto-generated method stub
		StringBuffer sqlb= new StringBuffer(" SELECT SUM(money) as money , COUNT(DISTINCT(userId)) as userCount , projectId FROM "+DonateRecordCharityProject.tableName+" where 1=1  ");
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
	public List<Map<String, Object>> getCharityRecordList(Long id) {
		// TODO Auto-generated method stub
		String sql=" select * ,DATE_FORMAT(createTime,\"%Y-%m-%d\") as createTimeFormat, DATE_FORMAT(recordTime,\"%Y-%m-%d\") as recordTimeFormat   from "+CharityRecord.tableName+" where charityProjectId = ? and isDelete  = 0 ";
		
		return sqlDao.queryForList(sql,id);
	}

	@Override
	public PageList<Map<String, Object>> LoadCharityDonateRecord(Integer currentPage,
			Integer pageSize) {
		// TODO Auto-generated method stub
		String sql=" select d.* , u.loginName , u.name , DATE_FORMAT(d.createTime,\"%Y-%m-%d\") as createTimeFormat from "+DonateRecordCharityProject.tableName+" d left join "+WeiXinUser.tableName+" u on(d.userId=u.id) where 1=1 ";
		return sqlDao.getPageList(sql, currentPage, pageSize);
	}

	@Override
	public PageList<Map<String, Object>> LoadCharityRecord(Integer currentPage,
			Integer pageSize, Long id) {
		// TODO Auto-generated method stub
		String sql=" select * , DATE_FORMAT(recordTime,\"%Y-%m-%d\") as recordTimeFormat ,DATE_FORMAT(createTime,\"%Y-%m-%d\") as createTimecreateTimeFormat from "+CharityRecord.tableName+" where charityProjectId = ? and isDelete = 0 order by id desc  ";
		return sqlDao.getPageList(sql, currentPage, pageSize, id);
	}

	@Override
	public void saveCharityRecord(CharityRecord cr) {
		// TODO Auto-generated method stub
		cr.setCreateTime(new Date());
		cr.setIsDelete(0);
		hqlDao.save(cr);
	}

	@Override
	public CharityRecord getCharityRecord(Long id) {
		// TODO Auto-generated method stub
		return hqlDao.get(CharityRecord.class, id);
	}

	@Override
	public void updateCharityRecord(CharityRecord cr) {
		// TODO Auto-generated method stub
		hqlDao.update(cr);
	}

}
