package com.tag.functions;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.site.service.ArticleService;
import com.site.vo.ArticleSearchVo;

@Component
public class ArticleFunctionTag {
	
	@Autowired
	private ArticleService articleService;

	private static ArticleFunctionTag articleFunctionTag;
	
	@PostConstruct
	public void init(){
		articleFunctionTag = this;
		articleFunctionTag.articleService = this.articleService;
	}
	
	/**
	 * 统计改网站用户发表新闻数排名
	 * @param siteId 网站ID
	 * @param limitUserNum 取出条数
	 * @return
	 */
	@SuppressWarnings("unused")
	public static List<Map<String, Object>> getUserArticleStatistics(Integer siteId,
			Integer limitUserNum) {
		List<Map<String, Object>> list = articleFunctionTag.articleService.statisticsUserArticle(siteId, limitUserNum);
		return articleFunctionTag.articleService.statisticsUserArticle(siteId, limitUserNum);
	}

	/**
	 * 统计改网站用户发表新闻数排名
	 * @param siteId 网站ID
	 * @param limitUserNum 取出条数
	 * @return
	 */
	public static List<Map<String, Object>> getColumnArticleStatistics(Integer siteId,
			Integer limitUserNum) {
		return articleFunctionTag.articleService.statisticsColumnArticle(siteId, limitUserNum);
	}
	
	/**
	 * 获取新闻数据
	 * @param siteId 网站id
	 * @param ColumnId 栏目id
	 * @return
	 */
	public static List<Map<String, Object>> getArticleListByColumnId(Integer siteId, Integer columnId, Integer limit){
		ArticleSearchVo searchVo = new ArticleSearchVo();
		if( limit != null ){
			searchVo.setLimit(limit);
		}
		searchVo.setSiteId(siteId);
		searchVo.setColumnId(columnId);
		searchVo.setIncludeSub(true);
		return articleFunctionTag.articleService.findArticleList(searchVo);
	}
	
}
