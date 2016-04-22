package com.weixin.common;

import com.weixin.vo.Token;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIUtils;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.*;

/**
 * Created by dzf on 2015/7/10.
 */
public class TokenFactory {

    private static Token token = null;

    private static final int TIME = 20000;

    /**
     * 获取全局凭证
     * @return
     */
    public static Token get(){
        if(token == null
                || (token.getCreate_time() + token.getExpires_in()*1000) < (System.currentTimeMillis() - TIME)){
            try {
                token = load();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return token;
    }

    private static Token load() throws IOException {
        HttpClient client = HttpClients.createDefault();
        List<NameValuePair> params = new ArrayList<NameValuePair>(3);
        params.add(new BasicNameValuePair("grant_type", "client_credential"));
        params.add(new BasicNameValuePair("appid", Configuration.APP_ID));
        params.add(new BasicNameValuePair("secret", Configuration.APP_SECRET));
        HttpPost httpPost = new HttpPost(Configuration.Urls.GET_TOKEN + "?" + URLEncodedUtils.format(params, "UTF-8"));
        HttpResponse response = client.execute(httpPost);
        if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
            String content = EntityUtils.toString(response.getEntity());
            JSONObject obj = (JSONObject) new JSONTokener(content).nextValue();
            if(obj.containsKey("access_token")){
                String access_token = obj.getString("access_token");
                int expires_in = obj.getInt("expires_in");
                System.out.println(access_token);
                return new Token(access_token, expires_in);
            }else{
                System.out.println(content);
            }
        }
        return null;
    }

    /**
     * 获取内嵌网页信息授权
     * @param code
     * @return
     */
    public static Map<String, Object> getWebToken(String code){
        HttpClient client = HttpClients.createDefault();
        List<NameValuePair> params = new ArrayList<NameValuePair>(3);
        params.add(new BasicNameValuePair("grant_type", "authorization_code"));
        params.add(new BasicNameValuePair("code", code));
        params.add(new BasicNameValuePair("appid", Configuration.APP_ID));
        params.add(new BasicNameValuePair("secret", Configuration.APP_SECRET));
        HttpPost httpPost = new HttpPost(Configuration.Urls.WEB_GET_TOKEN + "?" + URLEncodedUtils.format(params, "UTF-8"));
        try{
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
                String content = EntityUtils.toString(response.getEntity());
                JSONObject obj = (JSONObject) new JSONTokener(content).nextValue();
                if(obj.containsKey("access_token")){
                    Map<String, Object> result = new HashMap<String, Object>(6);
                    Iterator keys = obj.keys();
                    while (keys.hasNext()){
                        String key = (String) keys.next();
                        if(key.equals("expires_in")){
                            result.put(key, obj.getInt(key));
                            continue;
                        }
                        result.put(key, obj.getString(key));
                    }
                    return result;
                }
                System.out.println(content);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

}
