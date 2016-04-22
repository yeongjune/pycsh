package com.weixin.common;

import java.text.SimpleDateFormat;

/**
 * 配置文件
 * Created by dzf on 2015/7/10.
 */
public class Configuration {

    public static final String APP_ID = "wx8ac5c7d84d8a17a5";// 微信应用id

    public static final String APP_SECRET = "4a077a57457242fee663376440031826";//授权码

    public static final String MCH_ID = "1254790401";// 商务id

    public static final String PAY_KEY = "panyuqucishanhuiweixingongzongpt";

    public static final String SESSION_USER_KEY = "wei_xin_session_user_content";

    public static final String SESSION_USER_INFO_KEY = "wei_xin_session_user_info";

    /**
     * 与第三方数据交互返回的状态码
     */
    public static final String RESP_CODE_SUCCEED = "SUCCESS";
    public static final String RESP_CODE_FAIL = "FAIL";

    public static final SimpleDateFormat dateFormater = new SimpleDateFormat("yyyyMMddHHmmss");

    public static class Urls{

        public static final String HOSTS = "http://pycs.org.cn/";

        private static final String BASE_URL = "https://api.weixin.qq.com/cgi-bin";

        public static final String BIND_PHONE_ACTION = "/wxUser/toBindPhone.action";

        public static final String WEI_XIN_BIND_PHONE = HOSTS + BIND_PHONE_ACTION;

        /**
         * 获取网页授权code
         */
        public static final String WEB_GET_CODE = "https://open.weixin.qq.com/connect/oauth2/authorize";

        /**
         * 获取网页接口授权
         */
        public static final String WEB_GET_TOKEN = "https://api.weixin.qq.com/sns/oauth2/access_token";
        /**
         * 获取用户信息数据
         */
        public static final String WEB_GET_USER_INFO = "https://api.weixin.qq.com/sns/userinfo";

        /**
         * 获取凭证
         */
        public static final String GET_TOKEN = BASE_URL + "/token";

        /**
         * 创建菜单
         */
        public static final String CREATE_MENU = BASE_URL + "/menu/create";

        /**
         * 删除菜单
         */
        public static final String DELETE_MENU = BASE_URL + "/menu/delete";

        /**
         * 查询菜单
         */
        public static final String QUERY_MENU = BASE_URL + "/menu/get";

    }

}
