package com.sweep.controller;

import com.github.pagehelper.PageHelper;
import com.sweep.common.ServerResponse;
import com.sweep.pojo.*;
import com.sweep.pojo.ExEnters;
import com.sweep.service.AdminService;
import com.sweep.service.CorpsService;
import com.sweep.service.EntersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    @Autowired
    private EntersService entersService;
    @Autowired
    private CorpsService corpsService;
    @RequestMapping("/adminLogin")
    public void userLogin(String username, String password, String captcha, HttpServletResponse response, HttpServletRequest request) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        captcha=captcha.toUpperCase();
        if (!captcha.equals(request.getSession().getAttribute("validateCode"))){
            response.sendRedirect(request.getContextPath()+"/first/admin_login.jsp?info=1");//验证码输入错误
            return;
        }
        else{
            Admin currentUser=adminService.selectAdminByNameAndPass(username,password);
            if (currentUser!=null){
                List<Enters> enters=entersService.selectUntreated();
                List<Corps> corps=corpsService.selectUntreated();
                request.getSession().setAttribute("nowUser",currentUser);
                request.getSession().setAttribute("power","1");//存储权限，1为管理员
                System.out.println("enters:"+enters.size()+"  corps:"+corps.size());
                request.setAttribute("number",enters.size()+corps.size());
                request.getRequestDispatcher("../WEB-INF/pages/admin/admin_index.jsp").forward(request,response);
                return;
            }else {
                response.sendRedirect(request.getContextPath()+"/first/admin_login.jsp?info=0");//用户找不到
                return;
            }
        }
    }

    @RequestMapping("/addAdmin")
    @ResponseBody
    public ServerResponse addAdmin(Admin admin){
        int code=adminService.addAdmin(admin);
        if (code>0){
            return ServerResponse.createBySuccess();
        }else{
            return ServerResponse.createByError();
        }
    }
    @RequestMapping("/getAdmin")
    @ResponseBody
    public ServerResponse getAdmin(){
        List<Admin> admins=adminService.selectAdmin();
        return ServerResponse.createBySuccess(admins);
    }

    @RequestMapping("/firstadmin")
    public void firstadmin(HttpSession session,HttpServletRequest request,HttpServletResponse response){
        Object object=session.getAttribute("nowUser");
        try {
        if (object instanceof Admin){
                request.getRequestDispatcher("../WEB-INF/pages/admin/admin_index.jsp").forward(request,response);
        }else{
            response.sendRedirect(request.getContextPath()+"/first/admin_login.jsp");
        }
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/handle")
    @ResponseBody
    public Map<String,Object> handle(int page,int limit){
        Map<String,Object> map=new HashMap<>();
        List<ExEnters> exEnters=entersService.selectExEnters();
        PageHelper.startPage(page, limit);
        List<ExEnters> exEnters1=entersService.selectExEnters();
        System.out.println("报名数量"+exEnters1.size());
        map.put("code",0);
        map.put("msg","");
        map.put("count",exEnters.size());
        map.put("data",exEnters1);
        return map;
    }

    @RequestMapping("/corpshandle")
    @ResponseBody
    public Map<String,Object> corpshandle(int page,int limit){
        Map<String,Object> map=new HashMap<>();
        List<ExCorps> exCorps=corpsService.selectExCorps();
        PageHelper.startPage(page, limit);
        List<ExCorps> exCorps1=corpsService.selectExCorps();
        map.put("code",0);
        map.put("msg","");
        map.put("count",exCorps.size());
        map.put("data",exCorps1);
        return map;
    }
}
