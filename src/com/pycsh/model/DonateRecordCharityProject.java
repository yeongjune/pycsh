package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * 慈善项目捐赠记录表
 * @author Administrator
 *
 */
@Entity
@Table(name="pycsh_donate_record_charity_project")
public class DonateRecordCharityProject {

    public static final String tableName;
    public static final String modelName;
    static{
        Class c = DonateRecordCharityProject.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }

	public static String getTableName(){
		return tableName;
	}


	@Id
	@GeneratedValue
	private Long id;
	
	/**
	 * 捐的钱
	 */
	private Double money;
	
	
	/**
	 * 捐赠项目
	 */
	private Long projectId;
	
	/**
	 * 捐赠者id
	 */
	private Long userId;
	
	/**
	 * 捐赠时间
	 */
	private Date createTime;
	
	/**
	 * 捐赠id
	 */
	private Long donateId;
	
	/**
	 * 操作用户
	 */
	private Integer operatorId; 
	
	/**
	 * 活动Id
	 */
	private Long actId;
	
	/**
	 * 是否已发送过短信通知
	 */
	private Integer isSendMsg;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}



	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public Long getDonateId() {
		return donateId;
	}

	public void setDonateId(Long donateId) {
		this.donateId = donateId;
	}

	public Integer getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}

	public Long getActId() {
		return actId;
	}

	public void setActId(Long actId) {
		this.actId = actId;
	}

	public Integer getIsSendMsg() {
		return isSendMsg;
	}

	public void setIsSendMsg(Integer isSendMsg) {
		this.isSendMsg = isSendMsg;
	}
	
	

}
