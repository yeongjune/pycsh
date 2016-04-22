package com.pycsh.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pycsh_charity_project")
public class CharityProject {
	
	public static final String tableName;
    public static final String modelName;
    static{
        Class c = CharityProject.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Long id;
	
	private Long userId;
	
	private Long userSignId;
	
	
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
	 * 筹款目标
	 */
	private Double targer;
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
	private Integer type;

	/**
	 * 项目状态进展(1：发起，2：审核，3：募款，4：执行，5：结束)
	 */
	private Integer status;
	
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
	 * 申报书路径
	 */
	private String application;
	
	/**
	 * 申报书文件原名
	 */
	private String originalName;
	
	/**
	 * 审核意见
	 */
	private String opinions;
	
	/**
	 * 审核状态 
	 * 0 ，待审核
	 * 1，审核通过
	 * 2，审核不通过
	 */
	@Column(columnDefinition = "int default 0")
	private int checked = 0;
	
	private Date createTime;
	
	private Integer isDelete;
	
	private Integer isOpen;
	
	private Date modifed;

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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

	public Double getTarger() {
		return targer;
	}

	public void setTarger(Double targer) {
		this.targer = targer;
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

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Integer getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(Integer isOpen) {
		this.isOpen = isOpen;
	}

	public Date getModifed() {
		return modifed;
	}

	public void setModifed(Date modifed) {
		this.modifed = modifed;
	}

	public String getApplication() {
		return application;
	}

	public void setApplication(String application) {
		this.application = application;
	}

	public String getOriginalName() {
		return originalName;
	}

	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}

	public String getOpinions() {
		return opinions;
	}

	public void setOpinions(String opinions) {
		this.opinions = opinions;
	}
	
	
	

}
