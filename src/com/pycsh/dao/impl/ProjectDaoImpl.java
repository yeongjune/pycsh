package com.pycsh.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.ProjectDao;
import com.pycsh.model.Project;
import com.pycsh.model.ProjectType;

@Repository
public class ProjectDaoImpl implements ProjectDao{

	@Autowired
	private HQLDao hqlDao;

	@Autowired
	private SQLDao sqlDao;

	@Override
	public Serializable save(Map<String, Object> map) {
		return sqlDao.save(Project.tableName, map);
	}

	@Override
	public void delete(Integer id) {
		String sql = "update "+Project.tableName+" set isDelete=1 where id = "+id;
		sqlDao.execute(sql);
	}

	@Override
	public void update(Map<String, Object> map) {
		sqlDao.updateMap(Project.tableName, "id", map);
	}

	@Override
	public List<Map<String, Object>> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> find(Long id) {
		String sql = "select DATE_FORMAT(p.startTime,\"%Y-%m-%d\") as startTimeFormat , DATE_FORMAT(p.endTime,\"%Y-%m-%d\") as endTimeFormat , " +
				" p.*,t.name as typeName,t2.name as type2Name " +
				" from "+Project.tableName+" p " +
				" left join "+ProjectType.tableName+" t on p.type1=t.id " +
				" left join "+ProjectType.tableName+" t2 on p.type2=t2.id " +
				" where p.id ="+id;
		return sqlDao.queryForMap(sql);
	}

	public HQLDao getHqlDao() {
		return hqlDao;
	}

	public void setHqlDao(HQLDao hqlDao) {
		this.hqlDao = hqlDao;
	}

	public SQLDao getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(SQLDao sqlDao) {
		this.sqlDao = sqlDao;
	}

	@Override
	public PageList findProjectByMyPage(Integer currentPage, Integer pageSize,
			Long userId) {
		// TODO Auto-generated method stub
		String sql=" select sum(r.money) as sumMoney , p.* , DATE_FORMAT(p.startTime,\"%Y-%m-%d\") as startTimeFormat , DATE_FORMAT(p.endTime,\"%Y-%m-%d\") as endTimeFormat  from pycsh_donate_record_project r left join pycsh_project p on(r.projectId = p.id) where r.userId = ? group by r.projectId ";
		return sqlDao.getPageList(sql, currentPage, pageSize,userId);
	}


}
