package com.pycsh.dao;

import java.util.Map;

import com.base.vo.PageList;
import com.pycsh.model.Contribute;

public interface ContributeDao {
	
	void save(Contribute con);
	
	void update(Map<String,Object> con);
	
	Contribute getContribute(Long id);
	
	PageList findContributeByPage(Integer currentPage,Integer pageSize,String title,String author,String phone,Integer status );
	
	void deleteContribute(Long id);

}
