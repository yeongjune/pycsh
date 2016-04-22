package com.pycsh.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.vo.PageList;
import com.pycsh.dao.ContributeDao;
import com.pycsh.model.Contribute;
import com.pycsh.service.ContributeService;

@Service
public class ContributeServiceImpl implements ContributeService {

	@Autowired
	private ContributeDao dao;
	
	@Override
	public void save(Contribute con) {
		// TODO Auto-generated method stub
		dao.save(con);
	}

	@Override
	public void update(Map<String, Object> con) {
		// TODO Auto-generated method stub
		dao.update(con);
	}

	@Override
	public Contribute getContribute(Long id) {
		// TODO Auto-generated method stub
		return dao.getContribute(id);
	}

	@Override
	public PageList findContributeByPage(Integer currentPage, Integer pageSize,
			String title, String author, String phone, Integer status) {
		// TODO Auto-generated method stub
		return dao.findContributeByPage(currentPage, pageSize, title, author, phone, status);
	}

	@Override
	public void deleteContribute(Long id) {
		// TODO Auto-generated method stub
		dao.deleteContribute(id);
	}

}
