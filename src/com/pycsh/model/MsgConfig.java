package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="pycsh_msg_config")
public class MsgConfig {
	
	public static final String tableName;
    public static final String modelName;
    static{
        Class c = MsgConfig.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Integer id;
	
	private Integer msgConfig;
	
	private Integer msgCount;
	
	private Date modifyDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getMsgConfig() {
		return msgConfig;
	}

	public void setMsgConfig(Integer msgConfig) {
		this.msgConfig = msgConfig;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Integer getMsgCount() {
		return msgCount;
	}

	public void setMsgCount(Integer msgCount) {
		this.msgCount = msgCount;
	}
	
	

}
