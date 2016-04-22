package com.pycsh.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.base.vo.PageList;
import com.lottery.model.Lottery;

public interface ProjectService {


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
	List<Map<String, Object>> getList(String name,String startTime,String endTime,String status,String type1,String type2);
	/**
	 * 查询所有
	 * @param currentPage
	 * @param pageSize
	 * @param name 项目名称
	 * @param startTime 募款开始日期
	 * @param endTime 募款结束日期
	 * @param status 项目的状态
	 * @param type1 项目类型1
	 * @param type2 项目类型2
	 * @return
	 */
	PageList getPageList(Integer currentPage, Integer pageSize,String name,String startTime,String endTime,String status,String type1,String type2);

	/**
	 * 查询一个数据
	 * @param id
	 * @return
	 */
	Map<String, Object> find(Long id);
	
	/**项目的排序
	 * @param id
	 * @param flag
	 */
	int updateProjectSort(Integer id, Integer flag);
	/**修改项目的开放状态
	 * @param id
	 * @param flag
	 */
	void updateOpenStatus(Integer id, Integer flag);
	/**修改项目的进展
	 * @param id
	 * @param flag
	 */
	void updateProjectStatus(Integer id, String status);
	

	/**
	 * 我捐款的项目分页查询
	 * @param currentPage
	 * @param pageSize
	 * @param userId
	 * @return
	 */
	PageList findProjectByMyPage(Integer currentPage,Integer pageSize,Long userId);
	
	
}
