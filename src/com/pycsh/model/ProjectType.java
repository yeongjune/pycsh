package com.pycsh.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**番禺区慈善会——项目类型表
 * @author Administrator
 *
 */
@Entity
@Table(name="pycsh_project_type")
public class ProjectType implements Serializable{

	private static final long serialVersionUID = 4007084283457731860L;
	public static final String tableName;
	public static final String modelName;
	static{
        Class c = ProjectType.class;
		tableName = ((Table)c.getAnnotation(Table.class)).name();
		modelName = c.getSimpleName();
	}
	
	@Id
	@GeneratedValue
	private Long id;
	
	/**
	 * 名称
	 */
	private String name;
	
	/**
	 * 父级id
	 */
	private String pId;
	/**
	 * 类目
	 */
	private String category;
	/**
	 * 排序
	 */
	private Integer sort;
	/**
	 * 备注
	 */
	private String remarks;
	/**
	 * 是否删除(0=未删除，1=已删除)
	 */
	private String isDelete;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
}
