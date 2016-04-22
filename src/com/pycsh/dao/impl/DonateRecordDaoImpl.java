package com.pycsh.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.SQLDao;
import com.base.vo.PageList;
import com.pycsh.dao.DonateRecordDao;
import com.pycsh.model.DonateRecord;

@Repository
public class DonateRecordDaoImpl implements DonateRecordDao {

	@Autowired
	private SQLDao bs;
	
	@Override
	public Long save(Map<String, Object> record) {
		// TODO Auto-generated method stub
		record.put("createTime", new Date());
		return new Long(bs.save("pycsh_donate_record", record).toString());
	}

	@Override
	public void update(Map<String, Object> record) {
		// TODO Auto-generated method stub
		bs.updateMap("pycsh_donate_record", "id", record);
	}

	@Override
	public void update(Double lastMoney, Long id) {
		// TODO Auto-generated method stub
		bs.update(" update pycsh_donate_record set lastMoney = ? where id = ? ",lastMoney,id);
	}

	@Override
	public Map<String, Object> getDonateById(Long id) {
		// TODO Auto-generated method stub
		String sql = " select * from pycsh_donate_record where id = ? ";
		return bs.queryForMap(sql,id);
	}

	@Override
	public PageList findDonateByPage(Integer currentPage, Integer pageSize,
			Long userId) {
		// TODO Auto-generated method stub
		List<Object> objList=new ArrayList<Object>();
		String sql= " select r.* , u.loginName , u.name , DATE_FORMAT(r.createTime,\"%Y-%m-%d\") as createTimeFormat from pycsh_donate_record r left join pycsh_weixin_user u on(r.userId=u.id) where 1=1 ";
		if(userId!=null){
			
			sql+=" and r.userId = ? ";
			objList.add(userId);
		}
		sql+=" order by r.id desc ";
		return bs.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public List<Map<String, Object>> findDonateRecordList(Long id) {
		// TODO Auto-generated method stub
		String sql=" select rp.* , p.name , DATE_FORMAT(rp.createTime,\"%Y-%m-%d\") as createTimeFormat , u.name as userName  from pycsh_donate_record_project rp left join pycsh_project p on(rp.projectId = p.id) left join authority_user u on(rp.operatorId =u.id) where rp.donateId = ? ";
		
		return bs.queryForList(sql,id);
	}

	@Override
	public Map<String, Object> getDonateBySerialNo(String serialNo) {
		// TODO Auto-generated method stub
		String sql = " select * from pycsh_donate_record where serialNo = ? ";
		return bs.queryForMap(sql,serialNo);
	}

	@Override
	public Map<String, Object> getDonateSum() {
		// TODO Auto-generated method stub
		String sql=" select count(id) as donateCount, sum(money) sumMoney  from "+DonateRecord.tableName;
		return bs.queryForMap(sql);
	}

	@Override
	public List<Map<String, Object>> findRecordByProjectId(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

}
