package com.pycsh.vo;

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
public class ProjectTypeVo implements Serializable{
	private String id1;
	private String id2;
	private String defaultValue1;
	private String name1;
	private String name2;
	private String defaultValue2;
	public String getId1() {
		return id1;
	}
	public void setId1(String id1) {
		this.id1 = id1;
	}
	public String getId2() {
		return id2;
	}
	public void setId2(String id2) {
		this.id2 = id2;
	}
	public String getDefaultValue1() {
		return defaultValue1;
	}
	public void setDefaultValue1(String defaultValue1) {
		this.defaultValue1 = defaultValue1;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getName2() {
		return name2;
	}
	public void setName2(String name2) {
		this.name2 = name2;
	}
	public String getDefaultValue2() {
		return defaultValue2;
	}
	public void setDefaultValue2(String defaultValue2) {
		this.defaultValue2 = defaultValue2;
	}
	
}
