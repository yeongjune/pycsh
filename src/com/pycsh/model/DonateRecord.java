package com.pycsh.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * 捐赠记录表
 * @author Administrator
 *
 */
@Entity
@Table(name="pycsh_donate_record")
public class DonateRecord {

    public static final String tableName;
    public static final String modelName;
    static{
        Class c = DonateRecord.class;
        tableName = ((Table)c.getAnnotation(Table.class)).name();
        modelName = c.getSimpleName();
    }

	public static String getTableName(){
		return tableName;
	}

    /**
     * 订单状态
     */
    public static final int STATE_WAIT = 0;
    public static final int STATE_FAIL = -1;
    public static final int STATE_SUCCEED = 1;
    public static final int STATE_CLOSE = 2;

	@Id
	@GeneratedValue
	private Long id;
	
	/**
	 * 捐的钱
	 */
	private Double money;
	
	/**
	 * 捐赠者id
	 */
	private Long userId;
	
	/**
	 * 捐赠时间
	 */
	private Date createTime;
	
	/**
	 * 捐赠的途径(1=支付宝,2=微信)
	 */
	private Integer type;
	
	/**
	 * 捐款流水号
	 */
	private String serialNo;

    /**
     * 第三方支付平台单号
     */
    private String transactionId;

    /**
     *  支付结束时间
     */
    private Date endTime;

    /**
     * 订单状态
     */
    private int state = STATE_WAIT;
    
	/**
	 * 剩余金额
	 */
	private Double lastMoney;
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

	public Double getLastMoney() {
		return lastMoney;
	}

	public void setLastMoney(Double lastMoney) {
		this.lastMoney = lastMoney;
	}

}
