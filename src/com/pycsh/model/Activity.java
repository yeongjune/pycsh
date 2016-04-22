package com.pycsh.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 慈善活动
 * @author Administrator
 *
 */

@Entity
@Table(name="pycsh_activity")
public class Activity {
	
	

	public static final String tableName;
    public static final String modelName;
    static{
        Class c = Activity.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Long id;
	
	/**
	 * 项目Id
	 */
	private Long projectId;
	
	/**
	 * 标题
	 */
	private String name;
	
	/**
	 * 简介
	 */
	@Column(length=5000)
	private String introduce;
	/**
	 * 详细内容
	 */
	@Column(length=10000)
	private String contents;
	/**
	 * 已筹款
	 */
	private Double money;
	/**
	 * 已捐款人数
	 */
	private Integer amount;
	/**
	 * 筹款开始时间
	 */
	private Date startTime;
	/**
	 * 筹款结束时间
	 */
	private Date endTime;
	/**
	 * 项目类型
	 */
	private Integer type1;
	/**
	 * 项目类型
	 */
	private Integer type2;
	/**
	 * 项目状态进展(1：发起，2：审核，3：募款，4：执行，5：结束)
	 */
	private Integer status;
	
	/**
	 * 筹款方
	 */
	private String organization;
	
	/**
	 * 点击数
	 */
	private Long clickCount = 0L;
	
	/**
	 * 浏览数
	 */
	@Column(columnDefinition = "BIGINT default 0")
	private Long viewCount = 0L;
	
	
	/**
	 * 缩略图地址
	 */
	private String smallPicUrl;
	
	/**
	 * 缩略图原图地址:一般用于头部展示，或首页
	 */
	private String smallPicOriginalUrl;
	/**
	 * 审核状态 
	 * 0 ，无需审核
	 * 1 ，需要审核(待审核)
	 * 10，审核不通过
	 * 11，审核通过
	 */
	@Column(columnDefinition = "int default 0")
	private int checked = 0;
	/**
	 * 临时文件关联的ID
	 */
	private String tempId;
	/**
	 * 是否开放募捐（0=关闭募捐，1=开放募捐）
	 */
	private Integer isOpen;
	/**
	 * 是否删除(0=有效数据，1=无效数据（已删除）)
	 */
	private Integer isDelete;
	/**
	 * 创建时间
	 */
	private Date creTime;
	/**
	 * 最后修改时间
	 */
	private Date modifed;
	/**
	 * 创建人Id
	 */
	private Long userId;
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
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public Integer getType1() {
		return type1;
	}
	public void setType1(Integer type1) {
		this.type1 = type1;
	}
	public Integer getType2() {
		return type2;
	}
	public void setType2(Integer type2) {
		this.type2 = type2;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getOrganization() {
		return organization;
	}
	public void setOrganization(String organization) {
		this.organization = organization;
	}
	public Long getClickCount() {
		return clickCount;
	}
	public void setClickCount(Long clickCount) {
		this.clickCount = clickCount;
	}
	public Long getViewCount() {
		return viewCount;
	}
	public void setViewCount(Long viewCount) {
		this.viewCount = viewCount;
	}
	public String getSmallPicUrl() {
		return smallPicUrl;
	}
	public void setSmallPicUrl(String smallPicUrl) {
		this.smallPicUrl = smallPicUrl;
	}
	public String getSmallPicOriginalUrl() {
		return smallPicOriginalUrl;
	}
	public void setSmallPicOriginalUrl(String smallPicOriginalUrl) {
		this.smallPicOriginalUrl = smallPicOriginalUrl;
	}
	public int getChecked() {
		return checked;
	}
	public void setChecked(int checked) {
		this.checked = checked;
	}
	public String getTempId() {
		return tempId;
	}
	public void setTempId(String tempId) {
		this.tempId = tempId;
	}
	public Integer getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(Integer isOpen) {
		this.isOpen = isOpen;
	}
	public Integer getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	public Date getCreTime() {
		return creTime;
	}
	public void setCreTime(Date creTime) {
		this.creTime = creTime;
	}
	public Date getModifed() {
		return modifed;
	}
	public void setModifed(Date modifed) {
		this.modifed = modifed;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getProjectId() {
		return projectId;
	}
	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	
	
	
}
