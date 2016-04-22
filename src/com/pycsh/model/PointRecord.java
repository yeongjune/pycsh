package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="pycsh_point_record")
public class PointRecord {
	

	public static final String tableName;
    public static final String modelName;
    static{
        Class c = PointRecord.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
    
	@Id
	@GeneratedValue
	private Long id;
	
	private Long userId;
	
	private Long charityProjectId;
	

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

	public Long getCharityProjectId() {
		return charityProjectId;
	}

	public void setCharityProjectId(Long charityProjectId) {
		this.charityProjectId = charityProjectId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	
	
	
	
}
