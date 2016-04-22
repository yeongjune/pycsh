package com.pycsh.util;

import java.util.Date;
import java.util.Random;

public class SerialNoUtil {
	
	private final static String[] donateType ={"","ap","wx"};

    /**
     * 支付宝方式
     */
	public final static Integer TYPE_ALIPAY = 1;

    /**
     * 微信支付方式
     */
	public final static Integer TYPE_WEIXIN = 2;

    /**
     * 生成订单号
     * @param type 支付方式 <br> {@link#TYPE_ALIPAY 支付宝方式} <br> {@link#TYPE_WEIXIN 微信支付方式}
     * @return
     */
	public static String getSerialNo(Integer type){
		Date date=new Date();
		return donateType[type]+date.getTime()+CaptchaUitl.getCaptcha(6);
	}

}
