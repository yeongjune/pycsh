package com.pycsh.service.impl;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.pycsh.model.Project;
import com.pycsh.model.ProjectType;
import com.pycsh.service.ProjectTypeService;

@Service
public class ProjectTypeServiceImpl implements ProjectTypeService{

	@Autowired
	private HQLDao hqlDao;

	@Autowired
	private SQLDao sqlDao;

	@Override
	public List<Map<String, Object>> getList(String pId, String category) {
		String sql = "SELECT * FROM "+ProjectType.tableName+" WHERE isDelete = 0";
		if (!StringUtil.isEmpty(pId)) {
			sql += " AND pId = "+pId;
		}
		if (!StringUtil.isEmpty(category)) {
			sql += " AND category = '"+category+"'";
		}
		sql += " ORDER BY sort asc";
		return sqlDao.queryForList(sql);
	}

	@Override
	public Serializable save(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlDao.save(ProjectType.tableName, map);
	}

	@Override
	public void delete(Integer id) {
		String sql = "update "+ProjectType.tableName+" set isDelete=1 where id = "+id;
		sqlDao.execute(sql);
		//删除二级
		String twoSql = "update "+ProjectType.tableName+" set isDelete=1 where pId = "+id;
		sqlDao.execute(twoSql);
	}

	@Override
	public void update(Map<String, Object> map) {
		sqlDao.updateMap(ProjectType.tableName, "id", map);
		
	}

	@Override
	public List<Map<String, Object>> getList(String name, String startTime,
			String endTime, String status, String type1, String type2) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageList getPageList(Integer currentPage, Integer pageSize,
			String name, String startTime, String endTime, String status,
			String type1, String type2) {
		List<String> paramList = new ArrayList<String>();
		String sql = "select * from "+ProjectType.tableName+" where isDelete = 0 ";
		if (!StringUtil.isEmpty(name)) {
			sql += " and name like ";
			paramList.add("%"+name+"%");
		}
		sql += " order by sort,pId asc";
		return sqlDao.getPageList(sql, currentPage, pageSize,paramList.toArray());
	}

	@Override
	public Map<String, Object> find(Long id) {
		String sql = "select t.*,t1.name as pName from "+ProjectType.tableName+" as t left join "+ProjectType.tableName+" as t1 on t.pId=t1.id where t.id= ?";
		return sqlDao.queryForMap(sql,id);
	}
	
}
