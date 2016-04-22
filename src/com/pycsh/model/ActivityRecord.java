package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 慈善活动报名记录
 * @author Administrator
 *
 */

@Entity
@Table(name="pycsh_activity_record")
public class ActivityRecord {
	
	public static final String tableName;
    public static final String modelName;
    static{
        Class c = ActivityRecord.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Long id;
	
	/**
	 * 活动Id
	 */
	private Long actId;
	
	/**
	 * 报名用户
	 */
	private Long userId;
	
	/**
	 * 序列号
	 */
	private String code;
	
	/**
	 * 捐赠记录(recordTemp)Id
	 */
	private Integer recordId;
	
	/**
	 * 捐赠金额
	 */
	private Double money;
	
	/**
	 * 姓名
	 */
	private String name;
	
	/**
	 * 联系电话
	 */
	private String phone;
	
	/**
	 * 身份证
	 */
	private String idcard;
	
	/**
	 * 紧急联系电话
	 */
	private String exPhone;
	
	
	private Date createTime;
	
	/**
	 * 支付状态1=已支付
	 */
	private Integer status;
	
	/**
	 * 是否已发送短信通知,0=未发送,1=已发送
	 */
	private Integer isSendMsg;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getActId() {
		return actId;
	}

	public void setActId(Long actId) {
		this.actId = actId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getRecordId() {
		return recordId;
	}

	public void setRecordId(Integer recordId) {
		this.recordId = recordId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getExPhone() {
		return exPhone;
	}

	public void setExPhone(String exPhone) {
		this.exPhone = exPhone;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getIsSendMsg() {
		return isSendMsg;
	}

	public void setIsSendMsg(Integer isSendMsg) {
		this.isSendMsg = isSendMsg;
	}
	
	
	

}
