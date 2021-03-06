package com.apply.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 民航子弟初中新生入学报名表
 * @author ah
 * @time 2015-3-16
 *
 */
/*@Entity
@Table(name="zd_student2")*/
public class ZdStudent2 implements Serializable {

	private static final long serialVersionUID = -4355357310897237517L;
	public static final String tableName;
	public static final String modelName;
	
	static{
		Table t = ZdStudent2.class.getAnnotation(Table.class);
		tableName = t.name();
		modelName = ZdStudent2.class.getSimpleName();
	}

	/**
	 * 主键
	 */
	@Id
	@GeneratedValue
	private Integer id;
	/**
	 * 站点id
	 */
	private Integer siteId;
	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 曾用名
	 */
	private String usedName;
	/**
	 * 性别
	 */
	private String gender;
	/**
	 * 身份证号
	 */
	private String IDCard;
	
	/**
	 * 学籍号
	 *//*
	private String inSchoolNo;
	
	public String getInSchoolNo() {
		return inSchoolNo;
	}

	public void setInSchoolNo(String inSchoolNo) {
		this.inSchoolNo = inSchoolNo;
	}*/

	/**
	 * 所属籍贯省
	 */
	private String nativePlaceProvince;
	
	/**
	 * 所属籍贯市
	 */
	private String nativePlaceCity;
	
	/**
	 * 户籍所在省
	 */
	private String domiciProvince;
	
	/**
	 * 户籍所在-市
	 */
	private String domicilCity;
	/**
	 * 户籍所在-区/县
	 */
	private String domicileArea;
	/**
	 * 详细地址
	 */
	private String addressDetail;
	
	/**
	 * 户口性质
	 * 
	 */
	private String peasant;
	/**
	 * 家庭住址
	 */
	private String homeAddress;
	
	/**
	 * 家庭电话
	 */
	private String homePhone;
	
	/**
	 * 毕业学校
	 */
	private String graduate;
	
	/**
	 * 曾任何种职位
	 */
	private String position;
	/**
	 * 出生日期
	 */
	private Date birthday;
	/**
	 * 父亲联系手机
	 */
	private String fatherPhone;
	/**
	 * 母亲联系手机
	 */
	private String matherPhone;
	/**
	 * 获奖及个人特长
	 */
	@Column(length=2000)
	private String rewardHobby;
	
	/**
	 * 家庭主要成员1-姓名
	 */
	private String fullName1;
	/**
	 * 家庭主要成员1-关系
	 */
	private String relationship1;
	/**
	 * 家庭主要成员1-工作单位
	 */
	private String unit1;

	/**
	 * 家庭主要成员1-民族
	 */
	private String nationality1;
	
	/**
	 * 家庭主要成员1-身份证号
	 */
	private String IDCard1;
	
	/**
	 * 家庭主要成员1-户籍所在地
	 */
	private String domicile1;
	
	/**
	 * 家庭主要成员1-联系电话
	 */
	private String telephone1;
	/**
	 * 家庭主要成员2-姓名
	 */
	private String fullName2;
	/**
	 * 家庭主要成员2-关系
	 */
	private String relationship2;
	
	/**
	 * 家庭主要成员2-民族
	 */
	private String nationality2;
	
	/**
	 * 家庭主要成员2-身份证号
	 */
	private String IDCard2;
	
	/**
	 * 家庭主要成员2-户籍所在地
	 */
	private String domicile2;
	
	/**
	 * 家庭主要成员2-工作单位
	 */
	private String unit2;
	/**
	 * 家庭主要成员2-联系电话
	 */
	private String telephone2;
	/**
	 * 头像图片地址Id
	 */
	private String headPicUrl;
	
	
	/**
	 * 公司名(单位)
	 */
	private String companyName;

	/**
	 * 创建时间
	 */
	private Date createTime = new Date();
	
	/**
	 * 修改时间
	 */
	private Date updateTime = this.createTime;
	
	/**
	 * 是否已删除：0未删除，1已删除
	 * (用作标识是否已删除)
	 */
	private Integer isDelete=0;

	/**
	 * 报名状态：0待审核;1审核通过；2审核不通过
	 */
	private Integer status=1;
	
	/**
	 * 面试日期时间，格式yyyy-MM-dd HH:mm-HH:mm
	 */
	private String interviewDate;
	
	/**
	 * 是否参加面试；0：否、1：是
	 */
	private Integer interview=0;
	/**
	 * 面试成绩
	 */
	private Double interviewScore;
	/**
	 * 是否录取：-1未公布,0否，1是
	 */
	private Integer admit=-1;
	
	/**
	 *  审核备注
	 */
	private String checkRemark;
	
	/**
	 * 参加考试的批次
	 */
	private String batch;
	
	/**
	 * 帐号
	 */
	private String account;
	/**
	 * 密码
	 */
	private String password;
	
	/**
	 * 证件类型
	 */
	private String certificateType = "身份证";
	
	/**
	 * 父亲身份证
	 */
	private String fatherIDCard = "";
	
	/**
	 * 母亲身份证
	 */
	private String motherIDCard = "";
	
	/**
	 * 民族
	 */
	private String nationality;
	
	/**
	 * 健康状况
	 */
	private String healthyCondition;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 准考证
	 */
	private String testCard;
	
	/**
	 * 考室号
	 */
	private String roomNo = "";
	
	/**
	 * 出生地址
	 */
	private String birthdayAddress = "";
	
	/**
	 * 国家
	 */
	private String country = "";
	
	/**
	 * 姓名拼音
	 */
	private String namePinyin = "";
	
	/**
	 * 录取日期
	 */
	private Date enrolDate;
	
	/**
	 * 是否是港澳台侨外
	 * 0	否
	 * 	1	是
	 */
	@Column(columnDefinition="varchar(11) default '否'")
	private String isOutside;
	
	/**
	 * 通讯地址
	 */
	private String mailingAddress = "";
	
	/**
	 * 政治面貌
	 */
	private String politicsStatus;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSiteId() {
		return siteId;
	}

	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getIDCard() {
		return IDCard;
	}

	public void setIDCard(String iDCard) {
		IDCard = iDCard;
	}

	public String getNativePlaceProvince() {
		return nativePlaceProvince;
	}

	public void setNativePlaceProvince(String nativePlaceProvince) {
		this.nativePlaceProvince = nativePlaceProvince;
	}

	public String getNativePlaceCity() {
		return nativePlaceCity;
	}

	public void setNativePlaceCity(String nativePlaceCity) {
		this.nativePlaceCity = nativePlaceCity;
	}

	public String getDomiciProvince() {
		return domiciProvince;
	}

	public void setDomiciProvince(String domiciProvince) {
		this.domiciProvince = domiciProvince;
	}

	public String getDomicilCity() {
		return domicilCity;
	}

	public void setDomicilCity(String domicilCity) {
		this.domicilCity = domicilCity;
	}

	public String getDomicileArea() {
		return domicileArea;
	}

	public void setDomicileArea(String domicileArea) {
		this.domicileArea = domicileArea;
	}

	public String getHomeAddress() {
		return homeAddress;
	}

	public void setHomeAddress(String homeAddress) {
		this.homeAddress = homeAddress;
	}

	public String getGraduate() {
		return graduate;
	}

	public void setGraduate(String graduate) {
		this.graduate = graduate;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getFatherPhone() {
		return fatherPhone;
	}

	public void setFatherPhone(String fatherPhone) {
		this.fatherPhone = fatherPhone;
	}

	public String getMatherPhone() {
		return matherPhone;
	}

	public void setMatherPhone(String matherPhone) {
		this.matherPhone = matherPhone;
	}

	public String getRewardHobby() {
		return rewardHobby;
	}

	public void setRewardHobby(String rewardHobby) {
		this.rewardHobby = rewardHobby;
	}

	public String getFullName1() {
		return fullName1;
	}

	public void setFullName1(String fullName1) {
		this.fullName1 = fullName1;
	}

	public String getRelationship1() {
		return relationship1;
	}

	public void setRelationship1(String relationship1) {
		this.relationship1 = relationship1;
	}

	public String getUnit1() {
		return unit1;
	}

	public void setUnit1(String unit1) {
		this.unit1 = unit1;
	}

	public String getTelephone1() {
		return telephone1;
	}

	public void setTelephone1(String telephone1) {
		this.telephone1 = telephone1;
	}

	public String getFullName2() {
		return fullName2;
	}

	public void setFullName2(String fullName2) {
		this.fullName2 = fullName2;
	}

	public String getRelationship2() {
		return relationship2;
	}

	public void setRelationship2(String relationship2) {
		this.relationship2 = relationship2;
	}

	public String getUnit2() {
		return unit2;
	}

	public void setUnit2(String unit2) {
		this.unit2 = unit2;
	}

	public String getTelephone2() {
		return telephone2;
	}

	public void setTelephone2(String telephone2) {
		this.telephone2 = telephone2;
	}

	public String getHeadPicUrl() {
		return headPicUrl;
	}

	public void setHeadPicUrl(String headPicUrl) {
		this.headPicUrl = headPicUrl;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getHomePhone() {
		return homePhone;
	}

	public void setHomePhone(String homePhone) {
		this.homePhone = homePhone;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getInterviewDate() {
		return interviewDate;
	}

	public void setInterviewDate(String interviewDate) {
		this.interviewDate = interviewDate;
	}

	public Integer getInterview() {
		return interview;
	}

	public void setInterview(Integer interview) {
		this.interview = interview;
	}

	public Double getInterviewScore() {
		return interviewScore;
	}

	public void setInterviewScore(Double interviewScore) {
		this.interviewScore = interviewScore;
	}

	public Integer getAdmit() {
		return admit;
	}

	public void setAdmit(Integer admit) {
		this.admit = admit;
	}

	public String getCheckRemark() {
		return checkRemark;
	}

	public void setCheckRemark(String checkRemark) {
		this.checkRemark = checkRemark;
	}

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCertificateType() {
		return certificateType;
	}

	public void setCertificateType(String certificateType) {
		this.certificateType = certificateType;
	}

	public String getFatherIDCard() {
		return fatherIDCard;
	}

	public void setFatherIDCard(String fatherIDCard) {
		this.fatherIDCard = fatherIDCard;
	}

	public String getMotherIDCard() {
		return motherIDCard;
	}

	public void setMotherIDCard(String motherIDCard) {
		this.motherIDCard = motherIDCard;
	}

	public String getUsedName() {
		return usedName;
	}

	public void setUsedName(String usedName) {
		this.usedName = usedName;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getHealthyCondition() {
		return healthyCondition;
	}

	public void setHealthyCondition(String healthyCondition) {
		this.healthyCondition = healthyCondition;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getTestCard() {
		return testCard;
	}

	public void setTestCard(String testCard) {
		this.testCard = testCard;
	}

	public String getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}

	public String getBirthdayAddress() {
		return birthdayAddress;
	}

	public void setBirthdayAddress(String birthdayAddress) {
		this.birthdayAddress = birthdayAddress;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getNamePinyin() {
		return namePinyin;
	}

	public void setNamePinyin(String namePinyin) {
		this.namePinyin = namePinyin;
	}

	public Date getEnrolDate() {
		return enrolDate;
	}

	public void setEnrolDate(Date enrolDate) {
		this.enrolDate = enrolDate;
	}

	public String getMailingAddress() {
		return mailingAddress;
	}

	public void setMailingAddress(String mailingAddress) {
		this.mailingAddress = mailingAddress;
	}

	public String getNationality2() {
		return nationality2;
	}

	public void setNationality2(String nationality2) {
		this.nationality2 = nationality2;
	}

	public String getIDCard2() {
		return IDCard2;
	}

	public void setIDCard2(String iDCard2) {
		IDCard2 = iDCard2;
	}

	public String getIDCard1() {
		return IDCard1;
	}

	public void setIDCard1(String iDCard1) {
		IDCard1 = iDCard1;
	}

	public String getNationality1() {
		return nationality1;
	}

	public void setNationality1(String nationality1) {
		this.nationality1 = nationality1;
	}

	public String getDomicile2() {
		return domicile2;
	}

	public void setDomicile2(String domicile2) {
		this.domicile2 = domicile2;
	}

	public String getDomicile1() {
		return domicile1;
	}

	public void setDomicile1(String domicile1) {
		this.domicile1 = domicile1;
	}

	public String getPoliticsStatus() {
		return politicsStatus;
	}

	public void setPoliticsStatus(String politicsStatus) {
		this.politicsStatus = politicsStatus;
	}

	public String getIsOutside() {
		return isOutside;
	}

	public void setIsOutside(String isOutside) {
		this.isOutside = isOutside;
	}

	public String getPeasant() {
		return peasant;
	}

	public void setPeasant(String peasant) {
		this.peasant = peasant;
	}

}
