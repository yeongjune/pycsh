package com.site.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.HQLDao;
import com.base.dao.SQLDao;
import com.base.util.StringUtil;
import com.site.dao.ColumnDao;
import com.site.model.Article;
import com.site.model.Column;
import com.site.model.RoleColumn;
import com.site.model.UserColumnRole;

@Repository
public class ColumnDaoImpl implements ColumnDao {

	@Autowired
	private SQLDao dao;
	
	@Autowired
	private HQLDao hqlDao;

	@Override
	public Serializable save(Map<String, Object> map) {
		return dao.save(Column.tableName, map);
	}

	@Override
	public int delete(Integer id) {
		Map<String, Object> map = load(id);
		dao.update("update "+Column.tableName+" set pid=? where pid=?", map.get("pid"), id);
		return dao.delete(Column.tableName, id);
	}

	@Override
	public int update(Map<String, Object> map) {
		return dao.updateMap(Column.tableName, "id", map);
	}

	@Override
	public List<Map<String, Object>> getList(Integer siteId) {
		return dao.queryForList("select * from "+Column.tableName+" where siteId=?   order by pid, sort", siteId);
	}

	@Override
	public int update(List<Map<String, Object>> mapList) {
		return dao.updateMapList(Column.tableName, "id", mapList);
	}

	@Override
	public Map<String, Object> load(Integer id) {
		return dao.queryForMap("select * from "+Column.tableName+" where id=?", id);
	}

	@Override
	public List<Map<String, Object>> getYoungerBrothers(Integer id) {
		Map<String, Object> map = load(id);
		return dao.queryForList("select * from "+Column.tableName+" where pid=? and sort>?", map.get("pid"), map.get("sort"));
	}

	@Override
	public int deleteBySiteId(Integer siteId) {
		return dao.delete(Column.tableName, "siteId", siteId);
	}

	@Override
	public List<Map<String, Object>> selfAndParents(Integer siteId, Integer id) {
		List<Map<String, Object>> list = dao.queryForList("select * from "+Column.tableName+" where siteId=? ", siteId);
		if(list!=null && list.size()>0){
			Map<Object, Map<String, Object>> map = new HashMap<Object, Map<String,Object>>();
			for (Map<String, Object> column : list) {
				map.put(column.get("id"), column);
			}
			return selfAndParents(map, id);
		}
		return null;
	}

	private List<Map<String, Object>> selfAndParents(Map<Object, Map<String, Object>> map, Integer id) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if(map!=null && !map.isEmpty()){
			Map<String, Object> column = map.get(id);
			if(column != null && column.get("pid")!=null && !column.get("pid").equals(0)){
				list.addAll(selfAndParents(map, (Integer) column.get("pid")));
			}
			list.add(column);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> navigationWithChildren(Integer siteId) {
		List<Map<String, Object>> navigationColumn = dao.queryForList("select * from "+Column.tableName+" where siteId=? and navigation=1  order by sort asc ", siteId);
		if(navigationColumn==null || navigationColumn.isEmpty())return null;
		Map<Integer, List<Map<String, Object>>> mapListMap = assembleChildren(navigationColumn);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> map : navigationColumn) {
			if(map==null || map.isEmpty())continue;
			if(map.get("pid")==null || map.get("pid").equals(0)){
				map.put("children", mapListMap.get(map.get("id")));
				list.add(map);
			}
		}
		return list;
	}

	@Override
	public Map<String, Object> selfWithChildren(Integer siteId, int id) {
		Map<String, Object> map = dao.queryForMap("select * from "+Column.tableName+" where siteId=? and id=?", siteId, id);
		if(map==null || map.isEmpty())return null;
		List<Map<String, Object>> navigationColumn = dao.queryForList("select * from "+Column.tableName+" where siteId=?   order by sort asc ", siteId);
		Map<Integer, List<Map<String, Object>>> mapListMap = assembleChildren(navigationColumn);
		//System.out.println(mapListMap);
		map.put("children", mapListMap.get(id));
		return map;
	}

	private Map<Integer, List<Map<String, Object>>> assembleChildren(List<Map<String, Object>> list) {
		Map<Integer, List<Map<String, Object>>> mapListMap = new HashMap<Integer, List<Map<String,Object>>>();
		for (Map<String, Object> map : list) {
			if(map==null || map.isEmpty())continue;
			List<Map<String, Object>> mapList = mapListMap.get(map.get("pid"));
			if(mapList==null){
				mapList = new ArrayList<Map<String,Object>>();
				mapListMap.put((Integer) map.get("pid"), mapList);
			}
			mapList.add(map);
		}
		for (Map<String, Object> map : list) {
			if(map==null || map.isEmpty())continue;
			map.put("children", mapListMap.get(map.get("id")));
		}
		return mapListMap;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getListByIds(String ids) {
		String hql = "SELECT column.name FROM " + Column.modelName +  " AS column WHERE column.id in (" + ids + ")";
		return hqlDao.getListByHQL(hql);
	}

	@Override
	public List<Map<String, Object>> getList(Integer siteId, Integer userId) {
		String sql = 
			"select " +
			"	c.* " +
			"from " +
			"	"+Column.tableName+" as c, " +
			"	"+RoleColumn.tableName+" as rc, " +
			"	"+UserColumnRole.tableName+" as ucr " +
			"where " +
			"	c.siteId=? " +
			"	and ucr.userId=? " +
			"	and ucr.checked=1 " +
			"	and rc.checked=1 " +
			"	and ucr.roleId=rc.roleId " +
			"	and rc.columnId=c.id " +
			"order by c.pid, c.sort";
		return dao.queryForList(sql, siteId, userId);
	}

	@Override
	public List<Integer> getSelfAndAllChildrenId(int id) {
		String sqlTemp=" select getColumnChildList( ? ) as columnIds ";//getColumnChildList为数据库函数，返回包括该栏目和子栏目的ID
		Map<String, Object> idsMap=dao.queryForMap(sqlTemp,id);
		String columnIds=idsMap==null?"":idsMap.get("columnIds")+"";
		List<Integer> result=new ArrayList<Integer>();
		if (!StringUtil.isEmpty(columnIds)) {
		  List<String> tmpList=Arrays.asList(columnIds.split(","));
		  for (String columnId : tmpList) {
			  result.add(Integer.parseInt(columnId));
		  }
		}
		return result;
	}
	
	@Override
	public int getVoteNum(Integer columnId){
		String sql = "SELECT voteNum FROM " + Column.tableName + " WHERE id = ? ";
		return dao.queryForInt(sql, columnId);
	}
	
	@Override
	public int updateVoteNum(Integer columnId, Integer voteNum){
		String sql = " UPDATE " + Column.tableName + " SET voteNum = ? WHERE id = ?";
		return dao.update(sql, voteNum, columnId);
	}

	@Override
	public Map<String, Object> loadParent(Integer id) {
		String sql = "SELECT * FROM " + Column.tableName + " WHERE id = (SELECT pid FROM " + Column.tableName + " WHERE id = ?);";
		return dao.queryForMap(sql, id);
	}

	@Override
	public String getWelcomeText(){
		// TODO Auto-generated method stub
		String sql=" select a.content from "+Article.tableName+" a left join "+Column.tableName+" c on(a.columnId = c.id ) where c.name = ? ";
		Map<String,Object> map=dao.queryForMap(sql,"微信欢迎语");
		if(map!=null||map.get("content")!=null){
			return map.get("content").toString();
		}
		return "";
	}
}
