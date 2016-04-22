package com.site.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 用户投票记录
 * @author Administrator
 *
 */
public interface ArticleClickCountService {
	
	/**
	 * 保存用户投票记录
	 * @param articleId 文章ID
	 * @param userId
	 * @param count 文章点击数
	 * @return
	 */
	int save(Integer articleId, Integer userId);
	

	/**
	 * 查询某栏目下的投票总数
	 * @param columnId 栏目ID
	 * @return
	 */
	int checkTotalCount(Integer columnId);
	
	/**
	 * 获取某用户某栏目下已经进行投票的文章ID
	 * @param columnId
	 * @param userId
	 * @return
	 */
	List<Map<String,Object>> getClickedOption(Integer columnId, Integer userId);
	
	/**
	 * 批量保存投票记录
	 * @param columnId
	 * @param userId
	 * @param articleIds
	 * @return
	 */
	int updateClickCountBatch(Integer columnId, Integer userId, String articleIds);
}
