package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name="pycsh_weixin_user")
public class WeiXinUser {

    public static final String tableName;
    public static final String modelName;
    static{
        Class c = WeiXinUser.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }

	public static String getTableName(){
		return tableName;
	}
	
	@Id
	@GeneratedValue
	private Long id;

    /**
     * 微信与公众号的id
     */
    private String wxOpenId;

	/**
	 * 登录名(手机号)
	 */
	private String loginName;
	
	/**
	 * 密码
	 */
	private String password;
	
	/**
	 * 姓名
	 */
	private String name;
	
	/**
	 * 性别 1=男,2=女
	 */
	private Integer gender;
	
	/**
	 * 出生日期
	 */
	private Date birthday;
	
	/**
	 * 家庭电话
	 */
	private String homehone;
	
	/**
	 * 居住地址
	 */
	private String liveAddress;
	
	/**
	 * 邮箱
	 */
	private String email;
	
	/**
	 * 身份证号码
	 */
	private String idCard;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	
	/**
	 * 账号状态 0=默认,1=禁用
	 */
	private Integer status;
	
	/**
	 * 头像Url
	 */
	private String imgUrl;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getHomehone() {
		return homehone;
	}

	public void setHomehone(String homehone) {
		this.homehone = homehone;
	}

	public String getLiveAddress() {
		return liveAddress;
	}

	public void setLiveAddress(String liveAddress) {
		this.liveAddress = liveAddress;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

    public String getWxOpenId() {
        return wxOpenId;
    }

    public void setWxOpenId(String wxOpenId) {
        this.wxOpenId = wxOpenId;
    }

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
    
}
