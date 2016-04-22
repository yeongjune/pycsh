package com.pycsh.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.PointRecordDao;
import com.pycsh.model.PointRecord;
@Repository("pointRecordDaoImpl")
public class PointRecordDaoImpl implements PointRecordDao {
	@Autowired
	private SQLDao dao;
	
	@Override
	public PageList<PointRecord> getList(Integer currentPage, Integer pageSize, String date) {
		List<Object> list=new ArrayList<Object>();
		StringBuilder builder=new StringBuilder();
		builder.append(" SELECT * FROM ")
		.append(PointRecord.tableName)
		.append(" WHERE 1=1 ");
		if(StringUtils.isNotBlank(date)){
			builder.append(" AND  TO_DAYS(createTime) = TO_DAYS(?)");
			list.add(date);
		}
		return dao.getPageList(builder.toString(), currentPage, pageSize, list.toArray());
	}

	@Override
	public boolean addPointRecord(Map<String, Object> data) {
		Serializable save = dao.save(PointRecord.tableName, data);
		if(save!=null){
			return Boolean.TRUE;
		}
		return Boolean.FALSE;
	}

	@Override
	public Map<String,Object> getPointRecordByProjectId(long projectId) {
		String sql="SELECT * FROM "+PointRecord.tableName+" WHERE charityProjectId=?";
		return dao.queryForMap(sql,projectId);
	}

	@Override
	public int getPointCount(long projectId) {
		String sql=" SELECT COUNT(id) FROM "+PointRecord.tableName+" WHERE charityProjectId=?";
		return dao.queryForInt(sql,projectId);
	}

	@Override
	public int getBolCount(long projectId, long userId) {
		String sql=" SELECT COUNT(id) FROM "+PointRecord.tableName+" WHERE charityProjectId=? AND userId=?";
		return dao.queryForInt(sql, projectId,userId);
	}


}
