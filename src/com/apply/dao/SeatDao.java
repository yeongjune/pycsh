package com.apply.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.apply.model.Seat;
import com.base.vo.PageList;

public interface SeatDao {
	
	Serializable save(Seat seat);
	
	Serializable save(Map<String, Object> seat);
	
	int save(List<Map<String, Object>> listSeat);
	
	int update(Seat seat);
	
	int update(Map<String, Object> seat);
	
	int delete(Integer id);
	
	int deleteByExam(Integer examId);
	
	boolean hasExist(Integer siteId,Integer examId,Integer studentId);
	
	/**
	 *
	 * @author lfq
	 * @param examId
	 * @param studentIds 学生ID，多个用逗号隔开
	 * @return
	 */
	int deleteByExamAndStudent(Integer examId,String studentIds);
	
	Seat get(Integer id);
	
	Map<String, Object> load(Integer id);
	
	Map<String, Object> findMaxSeatByExam(Integer exam);
	
	/**
	 * 不分页查询列表
	 * @author lfq
	 * @param siteId		必须传，站点，否则不返回任何数据
	 * @param examId		非必须，考试Id
	 * @param roomNo		非必须，场室号
	 * @param examName		考试名，模糊查询
	 * @param studentName	考生名 ，模糊查询
	 * @param examDate		非必须，考试日期，完全匹配(格式：yyyy-MM-dd)
	 * @param examTime		非必须，考试时间，完全匹配(格式：09:00-12:00)
	 * @param start			非必须，从第几条记录开始查
	 * @param limit			非必须，返回记录数，非必须
	 * @return
	 */
	List<Map<String, Object>> findSeatList(Integer siteId,Integer examId,String roomNo,String examName,String studentName,String examDate,String examTime,Integer start,Integer limit);

	/**
	 * 不分页查询列表(重载)
	 * @author lfq
	 * @param siteId		必须传，站点，否则不返回任何数据
	 * @param examId		非必须，考试Id
	 * @param roomNo		非必须，场室号
	 * @param examName		考试名，模糊查询
	 * @param studentName	考生名 ，模糊查询
	 * @param examDate		非必须，考试日期，完全匹配(格式：yyyy-MM-dd)
	 * @param examTime		非必须，考试时间，完全匹配(格式：09:00-12:00)
	 * @param start			非必须，从第几条记录开始查
	 * @param limit			非必须，返回记录数，非必须
	 * @param examType			考试类型，不传表示不限，0表示小升初考试，1表示小学入学考试
	 * @return
	 */
	List<Map<String, Object>> findSeatList(Integer siteId,Integer examId,String roomNo,String examName,String studentName,String examDate,String examTime,Integer start,Integer limit, Integer examType);
	
	/**
	 * 分页查询列表
	 * @author lfq
	 * @param currentPage	必须，查询第几页
	 * @param pageSize		必须，每页记录数
	 * @param siteId		必须传，站点，否则不返回任何数据
	 * @param examId		非必须，考试Id
	 * @param roomNo		非必须，场室号
	 * @param examName		考试名，模糊查询
	 * @param studentName	考生名 ，模糊查询
	 * @param examDate		非必须，考试日期时间，完全匹配(格式：yyyy-MM-dd 09:00-12:00)
	 * @param examTime		非必须，考试时间，完全匹配(格式：09:00-12:00)
	 * @return
	 */
	PageList findSeatPageList(Integer currentPage,Integer pageSize,Integer siteId,Integer examId,String roomNo,String examName,String studentName,String examDate,String examTime);

	/**
	 * 分页查询列表
	 * @author lfq
	 * @param currentPage	必须，查询第几页
	 * @param pageSize		必须，每页记录数
	 * @param siteId		必须传，站点，否则不返回任何数据
	 * @param examId		非必须，考试Id
	 * @param roomNo		非必须，场室号
	 * @param examName		考试名，模糊查询
	 * @param studentName	考生名 ，模糊查询
	 * @param examDate		非必须，考试日期时间，完全匹配(格式：yyyy-MM-dd 09:00-12:00)
	 * @param examTime		非必须，考试时间，完全匹配(格式：09:00-12:00)
	 * @param examType		必须，考试类型，0表示小学，1表示中学
	 * @return
	 */
	PageList findSeatPageList(Integer currentPage,Integer pageSize,Integer siteId,Integer examId,String roomNo,String examName,String studentName,String examDate,String examTime, Integer examType);

	int update(List<Map<String, Object>> seatList);

	int deleteSeatNoByExam(Integer examId);

	int deleteByStudentIds(String studentIds);
	
	/**
	 * 查询考生的面试安排，无时返回null
	 * @author lifq
	 * @param siteId
	 * @param studentId
	 * @return
	 */
	List<Map<String, Object>> getStudentSeatList(Integer siteId,Integer studentId);
	
	/**
	 * 根据考试获取座位数量
	 * @author lfq
	 * @param examId
	 * @return
	 */
	int getCountByExamId(Integer examId);
}
