package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 活动报名签到表
 * @author Administrator
 *
 */

@Entity
@Table(name="pycsh_activity_sign")
public class ActivitySign {
	
	public static final String tableName;
    public static final String modelName;
    static{
        Class c = ActivitySign.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Long id;
	
	private Long actId;
	
	private String openId;
	
	private String name;
	
	private Date createTime;
	
	private Integer status;

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

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	

}
