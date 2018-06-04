package com.sweep.controller;

import com.github.pagehelper.PageHelper;
import com.sweep.common.ServerResponse;
import com.sweep.pojo.*;
import com.sweep.service.CorpsService;
import com.sweep.service.EntersService;
import net.sf.jsqlparser.schema.Server;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.Session;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/enters")
public class EntersController {
    @Autowired
    private EntersService entersService;
    @Autowired
    private CorpsService corpsService;

    @RequestMapping("/addEnter")
    @ResponseBody
    public ServerResponse addEnter(Enters enters, HttpSession session){
        User nowUser= (User) session.getAttribute("nowUser");
        Enters enter=entersService.selectExEnter(nowUser.getUserid(),enters.getMatchid());
        if (enter!=null){
            return ServerResponse.createByErrorMessage("对不起，不能重复报名！");
        }
        enters.setUserid(nowUser.getUserid());
        enters.setState(0);//默认状态为0（未受管理员处理）

        boolean isSuccess=entersService.insertEnters(enters);
        if (isSuccess){
            return ServerResponse.createBySuccessMessage("报名成功！");
        }else{
            return ServerResponse.createByErrorMessage("报名失败！");
        }
    }
    @RequestMapping("/reject")
    @ResponseBody
    public ServerResponse reject(int id){
        boolean isSuccess=entersService.setReject(id);
        if (isSuccess){
            return ServerResponse.createBySuccess();
        }else {
            return ServerResponse.createByError();
        }
    }
    @RequestMapping("/pass")
    @ResponseBody
    public ServerResponse pass(int entersid,int userid,int matchid){
        System.out.println("userid:"+userid+"  matchid:"+matchid);
        boolean isSuccess1=entersService.setPass(entersid);
        boolean isSuccess2=entersService.addEnters(userid,matchid);
        if (isSuccess1&&isSuccess2){
            return ServerResponse.createBySuccess();
        }else {
            return ServerResponse.createByError();
        }
    }

    @RequestMapping("/checkin")
    @ResponseBody
    public Map<String,Object> corpshandle(int page, int limit){
        Map<String,Object> map=new HashMap<>();
        List<ExEnters> exEnters=entersService.getEnters();
        PageHelper.startPage(page, limit);
        List<ExEnters> exEnters1=entersService.getEnters();
        System.out.println("limit:"+limit+"exEnters的size:"+exEnters.size()+"exEnters1:"+exEnters1.size());
        map.put("code",0);
        map.put("msg","");
        map.put("count",exEnters.size());
        map.put("data",exEnters1);
        return map;
    }


    @RequestMapping("/register")
    @ResponseBody
    public ServerResponse register(int entersid,String score,String describe){
       boolean isSuccess=entersService.updateEnters(entersid,score,describe);
       if (isSuccess){
           return ServerResponse.createBySuccess();
       }else {
           return ServerResponse.createByError();
       }
    }

    @RequestMapping("/cancle")
    @ResponseBody
    public ServerResponse mysign(int matchid,HttpSession session){
        User nowUser= (User) session.getAttribute("nowUser");
       Enters enter=entersService.selectExEnter(nowUser.getUserid(),matchid);

       Corps corps = corpsService.getMyCorp(nowUser.getEmail(),matchid);
        if (enter==null && corps==null){
            return ServerResponse.createByErrorMessage("对不起，您未报名此比赛！");
        }
        if (enter!=null){
            boolean isSuccess=entersService.cancle(nowUser.getUserid(),matchid);
            if (isSuccess){
                return ServerResponse.createBySuccessMessage("取消成功！");
            }else {
                ServerResponse.createByErrorMessage("取消失败！");
            }
        }
        else if (corps!=null){
            boolean isSuccess=corpsService.cancel(nowUser.getEmail(),matchid);
            if (isSuccess){
                return ServerResponse.createBySuccessMessage("战队比赛取消成功！");
            }else {
                return ServerResponse.createByErrorMessage("战队比赛取消失败！");
            }
        }
        return ServerResponse.createByErrorMessage("失败！");
    }

}
