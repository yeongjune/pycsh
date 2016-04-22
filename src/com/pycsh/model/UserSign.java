package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 用户申请信息
 * @author Administrator
 *
 */
@Entity
@Table(name="pycsh_user_sign")
public class UserSign {
	
	
	public static final String tableName;
    public static final String modelName;
    static{
        Class c = UserSign.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }
	
	@Id
	@GeneratedValue
	private Long id;;
	
	/**
	 * 用户Id
	 */
	private Long userId;
	
	/**
	 * 公司单位
	 */
	private String company;
	
	/**
	 * 法人代表
	 */
	private String corporation;
	
	/**
	 * 联系人
	 */
	private String contact;
	
	/**
	 * 联系电话
	 */
	private String contactPhone;
	
	/**
	 * 电子邮箱地址
	 */
	private String email;
	
	/**
	 * 证书照片地址
	 */
	private String registerImgUrl;
	
	/**
	 * 状态,0=未审核,1=审核通过,2=审核不通过
	 */
	private Integer status;
	
	/**
	 * 审核意见
	 */
	private String opinions;
	
	/**
	 * 承诺书路径
	 */
	private String promise;
	
	/**
	 * 申报书路径
	 */
	private String application;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	
	/**
	 * 认证时间
	 */
	private Date checkTime;

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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getCorporation() {
		return corporation;
	}

	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
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

	public String getRegisterImgUrl() {
		return registerImgUrl;
	}

	public void setRegisterImgUrl(String registerImgUrl) {
		this.registerImgUrl = registerImgUrl;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getOpinions() {
		return opinions;
	}

	public void setOpinions(String opinions) {
		this.opinions = opinions;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPromise() {
		return promise;
	}

	public void setPromise(String promise) {
		this.promise = promise;
	}

	public String getApplication() {
		return application;
	}

	public void setApplication(String application) {
		this.application = application;
	}
	
	

}
