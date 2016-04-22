package com.pycsh.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.ContributeDao;
import com.pycsh.model.Contribute;




@Repository
public class ContributeDaoImpl implements ContributeDao{

	@Autowired
	private SQLDao bs;
	
	@Autowired
	private HQLDao hqlDao;

	@Override
	public void save(Contribute con) {
		// TODO Auto-generated method stub
		hqlDao.save(con);
	}

	@Override
	public void update(Map<String, Object> con) {
		// TODO Auto-generated method stub
		bs.updateMap(Contribute.tableName, "id", con);
	}

	@Override
	public Contribute getContribute(Long id) {
		// TODO Auto-generated method stub
		
		return hqlDao.get(Contribute.class, id);
	}

	@Override
	public PageList findContributeByPage(Integer currentPage, Integer pageSize,
			String title, String author, String phone, Integer status) {
		// TODO Auto-generated method stub
		String sql=" select * from "+Contribute.tableName+" where 1=1 ";
		List<Object> objList =new ArrayList<Object>();
		
		if(title!=null&&!title.trim().equals("")){
			sql+=" and title like ? ";
			objList.add("%"+title+"%");
		}
		if(author!=null&&!author.trim().equals("")){
			sql+=" and author like ? ";
			objList.add("%"+author+"%");
		}
		if(phone!=null&&!phone.trim().equals("")){
			sql+=" and phone like ? ";
			objList.add("%"+phone+"%");
		}
		if(status!=null){
			sql+=" and status = ? ";
			objList.add(status);
		}
		sql+=" order by id  desc ";
		return bs.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public void deleteContribute(Long id) {
		// TODO Auto-generated method stub
		String sql = " delete from "+Contribute.tableName+" where id = ? ";
		bs.update(sql,id);
	}
	
}
