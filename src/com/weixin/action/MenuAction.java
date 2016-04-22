package com.weixin.action;

import com.weixin.common.Configuration;
import com.weixin.common.TokenFactory;
import com.weixin.vo.Token;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dzf on 2015/7/13.
 */
@Controller("WeiXinMenuAction")
@RequestMapping("/weiXinMenu")
public class MenuAction {

    @RequestMapping("/create")
    @ResponseBody
    public String create(){
        Map<String, Object> menu = new HashMap<String, Object>(1);
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(3);
        menu.put("button", list);
        List<Map<String,Object>> subMap=new ArrayList<Map<String,Object>>();
        Map<String,Object> sMap=new HashMap<String, Object>();
        sMap.put("type", "view");
        sMap.put("name", "爱心捐赠");
        sMap.put("url", Configuration.Urls.HOSTS+"wxUser/toIndex.action");
        subMap.add(sMap);
        sMap=new HashMap<String, Object>();
        sMap.put("type", "view");
        sMap.put("name", "捐赠查询");
        sMap.put("url", Configuration.Urls.HOSTS+"wxUser/toMyDonate.action");
        subMap.add(sMap);
        Map<String, Object> m1 = new HashMap<String, Object>(1);
        m1.put("name", "捐赠");
        m1.put("sub_button", subMap);
        //m1.put("key", "the_caring_donation");
        list.add(m1);

        subMap=new ArrayList<Map<String,Object>>();
        sMap=new HashMap<String, Object>();
        sMap.put("type", "view");
        sMap.put("name", "活动报名");
        sMap.put("url", Configuration.Urls.HOSTS+"wxUser/toActivityIndex.action");
        subMap.add(sMap);
        sMap=new HashMap<String, Object>();
        sMap.put("type", "view");
        sMap.put("name", "报名查询");
        sMap.put("url", Configuration.Urls.HOSTS+"wxUser/toMyActivity.action");
        subMap.add(sMap);
        Map<String, Object> m2 = new HashMap<String, Object>(3);
        m2.put("name", "活动");
        m2.put("sub_button", subMap);
        //m2.put("key", "donation_inquiry");
        list.add(m2);
        Map<String, Object> m3 = new HashMap<String, Object>(3);
       
        m3.put("name", "资讯中心");
        subMap=new ArrayList<Map<String,Object>>();
        sMap=new HashMap<String, Object>();
        
        sMap.put("type", "view");
        sMap.put("name", "媒体报道");
        sMap.put("url", Configuration.Urls.HOSTS+"/go-article_list.html");
        subMap.add(sMap);
        sMap=new HashMap<String, Object>();
        sMap.put("type", "view");
        sMap.put("name", "机构资讯");
        sMap.put("url", Configuration.Urls.HOSTS+"/go-article_list.html?type=2338");
        subMap.add(sMap);
        sMap=new HashMap<String, Object>();
        sMap.put("type", "view");
        sMap.put("name", "联系我们");
        sMap.put("url", Configuration.Urls.HOSTS+"/go-article_view.html?id=13200");
        subMap.add(sMap);
        m3.put("sub_button", subMap);
        list.add(m3);

        // 提交请求
        try{
            HttpClient client = HttpClients.createDefault();
            List<NameValuePair> params = new ArrayList<NameValuePair>(3);
            params.add(new BasicNameValuePair("access_token", TokenFactory.get().getAccess_token()));
            HttpPost httpPost = new HttpPost(Configuration.Urls.CREATE_MENU + "?" + URLEncodedUtils.format(params, "UTF-8"));
            StringEntity entity = new StringEntity(JSONObject.fromObject(menu).toString(), "utf-8");
            entity.setContentEncoding("UTF-8");
            entity.setContentType("application/json");
            httpPost.setEntity(entity);
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
                return EntityUtils.toString(response.getEntity());
                //JSONObject obj = (JSONObject) new JSONTokener(content).nextValue();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String delete(){
        try{
            HttpClient client = HttpClients.createDefault();
            List<NameValuePair> params = new ArrayList<NameValuePair>(3);
            params.add(new BasicNameValuePair("access_token", TokenFactory.get().getAccess_token()));
            HttpPost httpPost = new HttpPost(Configuration.Urls.DELETE_MENU + "?" + URLEncodedUtils.format(params, "UTF-8"));
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
                return EntityUtils.toString(response.getEntity());
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }

    @RequestMapping("/query")
    @ResponseBody
    public String query(){
        try{
            HttpClient client = HttpClients.createDefault();
            List<NameValuePair> params = new ArrayList<NameValuePair>(3);
            params.add(new BasicNameValuePair("access_token", TokenFactory.get().getAccess_token()));
            HttpPost httpPost = new HttpPost(Configuration.Urls.QUERY_MENU + "?" + URLEncodedUtils.format(params, "UTF-8"));
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
                return EntityUtils.toString(response.getEntity());
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }

}
