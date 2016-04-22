package com.pycsh.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.base.vo.PageList;
import com.pycsh.dao.UserSignDao;
import com.pycsh.model.CharityProject;
import com.pycsh.model.CharityRecord;
import com.pycsh.model.UserSign;
import com.pycsh.model.UserSignImg;
import com.pycsh.model.UserSignLog;
import com.pycsh.service.UserSignService;

@Service
public class UserSignServiceImpl implements UserSignService {
	
	@Autowired
	private UserSignDao dao;

	@Override
	public Long saveUserSign(String company, String corporation,
			String contact, String contactPhone, String email, String registerImgUrl, Long userId) {
		// TODO Auto-generated method stub
		UserSign us =new UserSign();
		us.setCompany(company);
		us.setCorporation(corporation);
		us.setContact(contact);
		us.setContactPhone(contactPhone);
		us.setEmail(email);
		us.setRegisterImgUrl(registerImgUrl);
		us.setUserId(userId);
		us.setStatus(0);
		return dao.saveUserSign(us);
	}

	@Override
	public UserSign getUserSign(Long id) {
		// TODO Auto-generated method stub
		return dao.getUserSign(id);
	}

	@Override
	public Map<String, Object> getUserSignMap(Long id) {
		// TODO Auto-generated method stub
		return dao.getUserSignMap(id);
	}

	@Override
	public void updateUserSign(Map<String, Object> us) {
		// TODO Auto-generated method stub
		dao.updateUserSign(us);
	}

	@Override
	public Map<String, Object> getUserSignByUserId(Long userId) {
		// TODO Auto-generated method stub
		return dao.getUserSignByUserId(userId);
	}

	@Override
	public PageList<Map<String, Object>> findUserSignByPage(
			Integer currentPage, Integer pageSize, Integer status,String keyword) {
		// TODO Auto-generated method stub
		return dao.findUserSignByPage(currentPage, pageSize, status,keyword);
	}

	@Override
	public Long saveCharityProject(CharityProject cp) {
		// TODO Auto-generated method stub

		return dao.saveCharityProject(cp);
	}

	@Override
	public CharityProject getCharityProject(Long id) {
		// TODO Auto-generated method stub
		return dao.getCharityProject(id);
	}

	@Override
	public Map<String, Object> getCharityProjectByMap(Long id) {
		// TODO Auto-generated method stub
		return dao.getCharityProjectByMap(id);
	}

	@Override
	public void updateCharityProjectMap(Map<String, Object> cp) {
		// TODO Auto-generated method stub
		dao.updateCharityProjectMap(cp);
	}

	@Override
	public PageList<Map<String, Object>> findCharityProjectByPage(
			Integer currentPage, Integer pageSize, Integer status, Long userId,
			Long userSignId, String name) {
		// TODO Auto-generated method stub
		return dao.findCharityProjectByPage(currentPage, pageSize, status, userId, userSignId, name);
	}

	@Override
	public Long saveUserSignImg(Long userId,Long userSignId,String imgUrl) {
		// TODO Auto-generated method stub
		UserSignImg usi =new UserSignImg();
		usi.setImgUrl(imgUrl);
		usi.setUserId(userId);
		usi.setUserSignId(userSignId);
		return dao.saveUserSignImg(usi);
	}

	@Override
	public void deleteUserSignImg(Long id, Long userId) {
		// TODO Auto-generated method stub
		dao.deleteUserSignImg(id, userId);
	}

	@Override
	public List<Map<String, Object>> findUserSignImg(Long userId) {
		// TODO Auto-generated method stub
		return dao.findUserSignImg(userId);
	}

	@Override
	public void updateCharityProject(CharityProject cp) {
		// TODO Auto-generated method stub
		dao.updateCharityProject(cp);
	}

	@Override
	public void saveUserSignLog(UserSignLog usl) {
		// TODO Auto-generated method stub
		dao.saveUserSignLog(usl);
	}

	@Override
	public PageList<Map<String, Object>> findCharityProjectByPage(
			Integer currentPage, Integer pageSize, String name,Integer type) {
		// TODO Auto-generated method stub
		return dao.findCharityProjectByPage(currentPage, pageSize, name, type);
	}

	@Override
	public List<Map<String, Object>> getCharityMoney(List<Long> idList) {
		// TODO Auto-generated method stub
		return dao.getCharityMoney(idList);
	}

	@Override
	public List<Map<String, Object>> getCharityRecordList(Long id) {
		// TODO Auto-generated method stub
		return dao.getCharityRecordList(id);
	}

	@Override
	public PageList<Map<String, Object>> LoadCharityDonateRecord(Integer currentPage,
			Integer pageSize) {
		// TODO Auto-generated method stub
		return dao.LoadCharityDonateRecord(currentPage, pageSize);
	}

	@Override
	public PageList<Map<String, Object>> LoadCharityRecord(Integer currentPage,
			Integer pageSize, Long id) {
		// TODO Auto-generated method stub
		return dao.LoadCharityRecord(currentPage, pageSize, id);
	}

	@Override
	public void saveCharityRecord(String title, String content,Date recordTime, Long id) {
		// TODO Auto-generated method stub
		CharityRecord cr = new CharityRecord();
		cr.setCharityProjectId(id);
		cr.setContents(content);
		cr.setRecordTime(recordTime);
		cr.setTitle(title);
		dao.saveCharityRecord(cr);
	}

	@Override
	public CharityRecord getCharityRecord(Long id) {
		// TODO Auto-generated method stub
		return dao.getCharityRecord(id);
	}

	@Override
	public void updateCharityRecord(CharityRecord cr) {
		// TODO Auto-generated method stub
		dao.updateCharityRecord(cr);
	}


}
