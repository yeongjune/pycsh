package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pycsh_user_sign_img")
public class UserSignImg {
	
	public static final String tableName;
    public static final String modelName;
    static{
        Class c = UserSignImg.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Long id;
	
	private Long userId;
	
	private Long userSignId;
	
	private String imgUrl;
	
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

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	
}
