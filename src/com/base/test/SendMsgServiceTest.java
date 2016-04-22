package com.base.test;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.pycsh.service.SendMsgService;

/**
 * 发送信息的测试类
 * @author 
 *
 */
public class SendMsgServiceTest {
	@Test
	public void testGetMoblieNo(){
		ApplicationContext ac = new ClassPathXmlApplicationContext("/com/base/config/applicationContext.xml");
		System.out.println("---------"+ac);
		SendMsgService send = (SendMsgService) ac.getBean("sendMsgServiceImpl");
		System.out.println("---------"+send);
		System.out.println("======================"+send.sendMsg("13725126272", "您的验证码是 : 1234"));
	}
	
}
