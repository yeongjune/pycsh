package com.pycsh.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.base.vo.PageList;
import com.pycsh.model.Project;

@Repository
public interface ProjectDao {

	/**
	 * 保存
	 * @param map {siteId:, name:, pid:, sort:, level:}
	 * @return
	 */
	Serializable save(Map<String, Object> map);

	/**
	 * 删除一个
	 * @param id
	 * @return
	 */
	void delete(Integer id);

	/**
	 * 修改
	 * @param map {id:, name:, type:, pid:, sort:, level:}
	 * @return
	 */
	void update(Map<String, Object> map);

	/**
	 * 查询所有
	 * @param siteId
	 * @return [{id:, siteId:, name:, type:, pid:, sort:, level:}]
	 */
	List<Map<String, Object>> getList();


	/**
	 * 查询一个数据
	 * @param id
	 * @return
	 */
	Map<String, Object> find(Long id);
	
	PageList findProjectByMyPage(Integer currentPage,Integer pageSize,Long userId);
	

}
