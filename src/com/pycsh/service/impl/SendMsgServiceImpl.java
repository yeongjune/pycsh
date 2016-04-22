package com.pycsh.service.impl;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.dao.SQLDao;
import com.base.util.SendMessagesUtil;
import com.base.vo.PageList;
import com.pycsh.model.MsgConfig;
import com.pycsh.model.MsgRecord;
import com.pycsh.service.SendMsgService;
@Service
public class SendMsgServiceImpl implements SendMsgService {

	@Autowired
	private SQLDao dao;

	@Override
	public boolean sendMsg(String mobilesStr, String msgContent) {
		//调用发送短信接口
		try {
			SendMessagesUtil send = new SendMessagesUtil();
			//剩余短信要大于发送短信数量才可发送
			send.sendByHttpPost(mobilesStr, msgContent, null);

			
		} catch (Exception e) {
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			System.out.println(f.format(new Date())+":SendMsgServiceImpl.java方法sendMsg发送短信报错!");
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public PageList findByPage(Integer currentPage, Integer pageSize,
			Integer type) {
		// TODO Auto-generated method stub
		List<Object> objList=new ArrayList<Object>();
		String sql=" select * , DATE_FORMAT(createTime,\"%Y-%m-%d %T\") as createTimeFormat from "+MsgRecord.tableName+" where 1=1 ";
		
		if(type!=null){
			sql+=" and type = ? ";
			objList.add(type);
		}
		sql+=" order by id desc ";
		return dao.getPageList(sql, currentPage, pageSize, objList.toArray());
	}

	@Override
	public void saveMsgRecord(String mobilesStr, String msgContent, Integer type) {
		// TODO Auto-generated method stub
		Map<String,Object> sendMap= new  HashMap<String, Object>();
		sendMap.put("createTime", new Date());
		sendMap.put("content",msgContent);
		sendMap.put("phone", mobilesStr);
		sendMap.put("type", type);
		dao.save(MsgRecord.tableName, sendMap);
	}

	@Override
	public Integer getMsgCount() {
		// TODO Auto-generated method stub
		String sql=" select msgConfig from "+MsgConfig.tableName+" ";
		return dao.queryForInt(sql);
	}

	@Override
	public Integer getLastCount() {
		// TODO Auto-generated method stub
		String sql=" select count(id) from "+MsgRecord.tableName+" ";
		Integer count=dao.queryForInt(sql);
		if(count==null){
			count = 0;
		}
		Integer lastCount = getMsgCount()-count;
		if(lastCount==100){
			sendMsg("13725126272", "慈善会短信剩余数已低于100条!");
		}
		return lastCount;
	}
	
}

