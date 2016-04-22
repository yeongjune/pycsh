package com.weixin.action;

import com.pycsh.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by dzf on 2015/7/20.
 */
@Controller
@RequestMapping("/wxproject")
public class WeiXinProjectAction {

    @Autowired
    private ProjectService projectService;

    @RequestMapping("/toIndex")
    public String toIndex(ModelMap map, HttpSession session){

        return "";
    }

}
