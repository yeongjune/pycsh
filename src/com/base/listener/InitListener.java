package com.base.listener;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.authority.service.UrlService;
import com.authority.service.UserService;
import com.base.config.Init;
import com.base.util.ContextAware;
import com.site.service.ImageService;
import com.tencent.WXPay;
import com.weixin.common.Configuration;

/**
 * Application Lifecycle Listener implementation class InitListener
 * 
 */
public class InitListener implements ServletContextListener {


	/**
	 * 系统所有url
	 */
	public static List<String> urlList = new ArrayList<String>();



	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	
	@Override
	public void contextInitialized(ServletContextEvent event) {

        //  初始化微信支付信息
        WXPay.initSDKConfiguration(Configuration.PAY_KEY, Configuration.APP_ID, Configuration.MCH_ID, "", "", "");

        Init.reload(event.getServletContext());
		
		// initialize system manager for "admin"
		UserService userService = ContextAware.getService(UserService.class);
		long count = userService.countByAccount(0, "admin");
		if(count<=0){
			userService.save("admin", "admin", 0);
		}

		UrlService urlService = ContextAware.getService(UrlService.class);
		urlService.updateUrls(event.getServletContext());
		
		String root = event.getServletContext().getRealPath("/");
		try {
			ImageService imageService= ContextAware.getService(ImageService.class);;
			//删除没用用到的新闻图片
			//imageService.deleteAllDisalbeFile(root);
		} catch (Exception e) {
			e.printStackTrace();
		}
        event.getServletContext().setAttribute("WebHosts", Configuration.Urls.HOSTS);
	}

}
