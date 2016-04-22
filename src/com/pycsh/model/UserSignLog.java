package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="pycsh_user_sign_log")
public class UserSignLog {
	
	
	private static final long serialVersionUID = 4007084283457731860L;
    public static final String tableName;
    public static final String modelName;
    static{
        Class c = UserSignLog.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Long id;
	
	
	private Long userId;
	
	private Long userSignId;
	
	private Integer checkUserId;
	
	private Integer status;
	
	private String opinions;
	
	private Date createTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getUserSignId() {
		return userSignId;
	}

	public void setUserSignId(Long userSignId) {
		this.userSignId = userSignId;
	}

	public Integer getCheckUserId() {
		return checkUserId;
	}

	public void setCheckUserId(Integer checkUserId) {
		this.checkUserId = checkUserId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getOpinions() {
		return opinions;
	}

	public void setOpinions(String opinions) {
		this.opinions = opinions;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	

}
