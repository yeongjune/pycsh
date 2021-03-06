package com.apply.dao.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.apply.dao.DzStudentDao;
import com.apply.model.DzStudent;
import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.util.StringUtil;
import com.base.vo.PageList;

@Component
public class DzStudentDaoImpl implements DzStudentDao {
	
	@Autowired
	private HQLDao hqlDao;
	
	@Autowired
	private SQLDao sqlDao;

	@Override
	public Integer saveOrUpdate(DzStudent dzStudent) {
		hqlDao.saveOrUpdate(dzStudent);
		return dzStudent.getId();
	}

	@Override
	public Integer delete(Integer siteId,Integer... id) {
		String sql="update "+DzStudent.tableName +" set isDelete=1 " +
				" where siteId = "+siteId+" and id in ( "+StringUtil.replaceCollectionToString(Arrays.asList(id))+" )";
		return hqlDao.updateBySQL(sql);
	}

	@Override
	public DzStudent getDzStudent(Integer id) {
		return hqlDao.get(DzStudent.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public PageList<DzStudent> getDzStudentPageList(Integer siteId,Integer pageSize,
			Integer currentPage, String keyword,String year) {
		String hql="FROM "+DzStudent.modelName+" as s WHERE s.isDelete=0 AND s.siteId= ? ";
		List<Object> params=new ArrayList<Object>();
		params.add(siteId);
		if (!StringUtil.isEmpty(keyword)) {
			hql +=" AND s.name like ? or s.graduate like ? or s.IDCard like ? or s.inSchoolNo like ? ";
			params.add("%"+keyword+"%");
			params.add("%"+keyword+"%");
			params.add("%"+keyword+"%");
			params.add("%"+keyword+"%");
		}
		if (!StringUtil.isEmpty(year)) {
			hql +=" AND DATE_FORMAT(s.createTime,'%Y')= ?  ";
			params.add(year);
		}
		hql +=" order by s.createTime desc ";
		return hqlDao.getPageListByHQL(hql, currentPage, pageSize, params.toArray());
	}

	@Override
	public List<Map<String, Object>> getDzStudentList(Integer siteId,String year, String keyword,Integer ...id) {
		String sql=" SELECT s.* "+
				" ,CONCAT(s.nativePlaceProvince,s.nativePlaceCity) AS nativePlace "+
				" ,IF(s.domicileArea IS NULL OR s.domicileArea='',CONCAT(s.domiciProvince,'市',s.domicilCity,'区'),CONCAT(s.domiciProvince,'省',s.domicilCity,'市',s.domicileArea)) AS domicil "+
				" ,IF(s.IsPeasant=0,'否','是') AS IsPeasant "+
				" ,CONCAT(s.relationship1,' 姓名:',s.fullName1,' 工作单位：',s.unit1,' 单位电话：',s.telephone1) AS familyMember1 "+
				" ,CONCAT(s.relationship2,' 姓名:',s.fullName2,' 工作单位：',s.unit2,' 单位电话：',s.telephone2) AS familyMember2 "+
				" FROM "+DzStudent.tableName+" AS s "+
				" WHERE s.isDelete=0 AND s.siteId = ? ";
		List<Object> params=new ArrayList<Object>();
		params.add(siteId);
		if (!StringUtil.isEmpty(keyword)) {
			sql +=" AND s.name like ? or s.graduate like ? or s.IDCard like ? or s.inSchoolNo like ? ";
			params.add("%"+keyword+"%");
			params.add("%"+keyword+"%");
			params.add("%"+keyword+"%");
			params.add("%"+keyword+"%");
		}
		if (!StringUtil.isEmpty(year)) {
			sql +=" AND DATE_FORMAT(s.createTime,'%Y')= ?  ";
			params.add(year);
		}
		if (id!=null && id.length>0) {
			sql += " AND s.id in ("+StringUtil.replaceCollectionToString(Arrays.asList(id))+")";
		}
		sql +=" order by s.createTime desc ";
		
		return sqlDao.queryForList(sql,params.toArray());
	}

}
