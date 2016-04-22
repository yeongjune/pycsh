package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="pycsh_msg_record")
public class MsgRecord {
	
	
	public static final String tableName;
    public static final String modelName;
    static{
        Class c = MsgRecord.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
    
	@Id
	@GeneratedValue
	private Long id;
	
	private String phone;
	
	/**
	 * 短信类型 1=验证码,2=分配捐款通知,3=自定义通知
	 */
	private Integer type;
	
	private Date createTime;
	
	private String content;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	

}
