package com.pycsh.service.impl;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.util.StringUtil;
import com.base.vo.PageList;
import com.lottery.dao.LotteryDao;
import com.lottery.dao.StudentDao;
import com.lottery.model.Lottery;
import com.lottery.model.Student;
import com.lottery.service.LotteryService;
import com.pycsh.dao.ProjectDao;
import com.pycsh.model.Project;
import com.pycsh.model.ProjectType;
import com.pycsh.service.ProjectService;
import com.pycsh.util.SerialNoUtil;
import com.site.model.Article;

@Service
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private ProjectDao projectDao;

	@Autowired
	private HQLDao hqlDao;

	@Autowired
	private SQLDao sqlDao;

	@Override
	public Serializable save(Map<String, Object> map) {
		return projectDao.save(map);
	}

	@Override
	public void delete(Integer id) {
		// TODO Auto-generated method stub
		projectDao.delete(id);
	}

	@Override
	public void update(Map<String, Object> map) {
		projectDao.update(map);
	}

	@Override
	public List<Map<String, Object>> getList(String name,String startTime,String endTime,String status,String type1,String type2) {
		// TODO Auto-generated method stub
		return projectDao.getList();
	}

	@Override
	public PageList getPageList(Integer currentPage, Integer pageSize,String name,String startTime,String endTime,String status,String type1,String type2) {
		StringBuffer sql = new StringBuffer();
		List<String> paramList = new ArrayList<String>();
		sql.append("select ROUND(targer,2) as targerFormat,DATE_FORMAT(startTime,\"%Y-%m-%d\") as startTimeFormat,DATE_FORMAT(endTime,\"%Y-%m-%d\") as endTimeFormat , a.*,t.name as typeName,t2.name as type2Name FROM "+Project.tableName+" as a ");
		sql.append(" left join "+ProjectType.tableName+" t on a.type1=t.id ");
		sql.append(" left join "+ProjectType.tableName+" t2 on a.type2=t2.id WHERE 1=1 and a.isDelete=0 ");
		if (!StringUtil.isEmpty(name)) {
			sql.append(" AND a.name like ?");
			paramList.add("%"+name+"%");
		}
		if (!StringUtil.isEmpty(startTime)) {
			sql.append(" AND startTime <= ?");
			paramList.add(startTime);
		}
		if (!StringUtil.isEmpty(endTime)) {
			sql.append(" AND endTime >= ?");
			paramList.add(endTime);
		}
		if (!StringUtil.isEmpty(status)) {
			
			if(status.indexOf(",")==-1){
				
				sql.append(" AND a.status = ? ");
				paramList.add(status);
			}else{
				String tmpSql=" AND a.status in(";
				for(String tmp:status.split(",")){
					tmpSql+="?,";
					paramList.add(tmp);
					
				}
				sql.append(tmpSql.substring(0,tmpSql.length()-1));
				sql.append(") ");
			}
		}
		if (!StringUtil.isEmpty(type1)) {
			sql.append(" AND type1 = ?");
			paramList.add(type1);
		}
		if (!StringUtil.isEmpty(type2)) {
			sql.append(" AND type2 = ?");
			paramList.add(type2);
		}
		return sqlDao.getPageList(sql.toString()+"order by a.id desc ", currentPage, pageSize, paramList.toArray());
	}

	@Override
	public Map<String, Object> find(Long id) {
		// TODO Auto-generated method stub
		return projectDao.find(id);
	}
	@Override
	public int updateProjectSort(Integer id, Integer flag) {
		int result=0;
		if (id==null||flag==null) {
			return result;
		}
		if (flag==1) {
			String sql=" select a.updateTime from "+Article.tableName +" a "+
						" where a.id <> ? and  a.updateTime >= (select b.updateTime from "+Article.tableName+" b where b.id= ? ) "+
						" and 	a.columnId=(select t.columnId from "+Article.tableName +" t where t.id= ? ) order by a.updateTime asc limit 1 ";
			Date updateTime=this.sqlDao.queryForObject(sql, Date.class, id,id,id);
			if (updateTime!=null) {
				updateTime.setTime(updateTime.getTime()+1000);
				Date d=new Date();
				if (updateTime.getTime()>d.getTime()) {
					updateTime=d;
				}
				sql="update "+Article.tableName + " set updateTime= ? where id = ? ";
				result=this.sqlDao.update(sql, updateTime,id);
			}
		}else if (flag==2) {
			String sql=" select a.updateTime from "+Article.tableName +" a "+
						" where a.id <> ? and  a.updateTime <= (select b.updateTime from "+Article.tableName+" b where b.id= ? ) "+
						" and 	a.columnId=(select t.columnId from "+Article.tableName +" t where t.id= ? ) order by a.updateTime desc limit 1 ";
			Date updateTime=this.sqlDao.queryForObject(sql, Date.class, id,id,id);
			if (updateTime!=null) {
				updateTime.setTime(updateTime.getTime()-1000);
				sql="update "+Article.tableName + " set updateTime= ? where id = ? ";
				result=this.sqlDao.update(sql, updateTime,id);
			}
		}else if (flag==3) {
			String sql="update "+Article.tableName + " set updateTime= ? where id = ? ";
			result=this.sqlDao.update(sql,(new Date()),id);
		}else if (flag==4) {
			String sql="select min(a.updateTime) from "+Article.tableName +" a where a.id <> ? and a.columnId=(select b.columnId from "+Article.tableName +" b where b.id= ? ) " ;
			Date updateTime=this.sqlDao.queryForObject(sql, Date.class, id,id);
			if (updateTime!=null) {
				updateTime.setTime(updateTime.getTime()-1000);
				sql="update "+Article.tableName + " set updateTime= ? where id = ? ";
				result=this.sqlDao.update(sql, updateTime,id);
			}
		}
		return result;
	}

	@Override
	public void updateOpenStatus(Integer id, Integer flag) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String sql = "update pycsh_project set isOpen = "+flag+",modifed='"+sdf.format(new Date())+"' where id="+id;
		sqlDao.execute(sql);
	}
	@Override
	public void updateProjectStatus(Integer id, String status) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String sql = "update pycsh_project set status = "+status+",modifed='"+sdf.format(new Date())+"' where id = "+id;
		sqlDao.execute(sql);
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

	public ProjectDao getProjectDao() {
		return projectDao;
	}

	public void setProjectDao(ProjectDao projectDao) {
		this.projectDao = projectDao;
	}

	@Override
	public PageList findProjectByMyPage(Integer currentPage, Integer pageSize,
			Long userId) {
		// TODO Auto-generated method stub
		return projectDao.findProjectByMyPage(currentPage, pageSize, userId);
	}


}
