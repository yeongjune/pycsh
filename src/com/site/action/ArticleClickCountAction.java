package com.site.action;

import java.io.IOException;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.base.util.JSONUtil;
import com.site.service.ArticleClickCountService;
import com.site.service.ArticleService;
import com.site.service.ColumnService;

@Controller
@RequestMapping("articleClickCount")
public class ArticleClickCountAction {
	
	@Autowired
	private ArticleClickCountService articleClickCountService;
	
	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private ColumnService columnService;
	
	/**
	 * 保存一条点击记录并增加文章的点击数
	 * @param request
	 * @param response
	 * @param articleId 文章ID 
	 * @param userId 用户ID
	 * @param count 用户点击数量
	 * @throws IOException 
	 */
	@RequestMapping("save")
	public void save(HttpServletRequest request, HttpServletResponse response, 
			Integer articleId, Integer userId) throws IOException{
		boolean result = false;
		if(articleId != null && userId != null){
			int obj = articleClickCountService.save(articleId, userId);
			if(obj > 0){
				result = true;
			}else{
				result = false;
			}
		}	
		response.getWriter().print(result);
	}
	
	/**
	 * 批量更新投票记录
	 * @param request
	 * @param response
	 * @param articleIds
	 * @param userId
	 * @param columnId
	 */
	@RequestMapping("batchSave")
	public void batchSave(HttpServletRequest request, HttpServletResponse response, 
			String articleIds, Integer userId, Integer columnId){
		if(articleIds != null && userId != null && columnId != null){
			int result = articleClickCountService.updateClickCountBatch(columnId, userId, articleIds);
			JSONUtil.printToHTML(response, result);
		}
	}
	
	@RequestMapping("index")
	public String index(HttpServletRequest request, HttpServletResponse response){
		return "site/clickcount/index";
	}
	
	/**
	 * 获取栏目可投票项数
	 * @param request
	 * @param response
	 * @param columnId
	 */
	@RequestMapping("checkTotalCount")
	public void checkTotalCount(HttpServletRequest request, HttpServletResponse response, Integer columnId){
		if(columnId != null){
			int num = articleClickCountService.checkTotalCount(columnId);
			JSONUtil.printToHTML(response, num);
		}
	}
	
	/**
	 * 更新新闻的截止时间
	 * @param request
	 * @param response
	 * @param ids
	 * @param lastTime
	 */
	@RequestMapping("updateLastTime")
	public void updateLastTime(HttpServletRequest request, HttpServletResponse response, 
			String ids, String lastTime){
		if(ids != null && lastTime != null){
			int result = articleService.updateLastTime(ids, lastTime);
			if(result > 0){
				JSONUtil.printToHTML(response, true);
			}else {
				JSONUtil.printToHTML(response, false);
			}
		}
	}
	
	/**
	 * 获取可投票项目数
	 * @param request
	 * @param response
	 * @param columnId
	 */
	@RequestMapping(value="getVoteNum")
	public void getVoteNum(HttpServletRequest request, HttpServletResponse response, 
			Integer columnId){
		if(columnId != null){
			int result = columnService.getVoteNum(columnId);
			JSONUtil.printToHTML(response, result);
		}
		
	}
	
	/**
	 * 更新可投票项目数
	 * @param request
	 * @param response
	 * @param columnId
	 * @param voteNum
	 */
	@RequestMapping(value="updateVoteNum")
	public void updateVoteNum(HttpServletRequest request, HttpServletResponse response, 
			Integer columnId, Integer voteNum){
		if(columnId != null && voteNum != null){
			int result = columnService.updateVoteNum(columnId, voteNum);
			JSONUtil.printToHTML(response, result);
		}
	}
	
	/**
	 * 获取某用户在某栏目下已经投票的文章项
	 * @param request
	 * @param response
	 * @param columnId
	 * @param userId
	 */
	@RequestMapping(value="getClickedOption")
	public void getClickedOption(HttpServletRequest request, HttpServletResponse response, 
			Integer columnId, Integer userId){
		if(columnId != null && userId != null){
			List<Map<String,Object>> result = articleClickCountService.getClickedOption(columnId, userId);
			JSONUtil.printToHTML(response, result);
		}
		
	}
}
