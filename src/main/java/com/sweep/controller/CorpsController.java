package com.sweep.controller;

import com.github.pagehelper.PageHelper;
import com.sweep.common.ServerResponse;
import com.sweep.pojo.Corps;
import com.sweep.pojo.ExCorps;
import com.sweep.pojo.User;
import com.sweep.service.CorpsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/corps")
public class CorpsController {
    @Autowired
    private CorpsService corpsService;
    @RequestMapping("/addCorps")
    @ResponseBody
    public ServerResponse addCorps(@RequestParam("image") MultipartFile image, Corps corps, HttpSession session){
        boolean isDuplicate=corpsService.isDuplicateName(corps.getCorpsName());
        if (!isDuplicate){
            return ServerResponse.createByErrorMessage("战队名已被占用");
        }
        User nowUser= (User) session.getAttribute("nowUser");
        String img="";
        if (!image.isEmpty()){
            img= UUID.randomUUID()+image.getOriginalFilename();
            try {
                image.transferTo(new File("D:\\picture\\"+img));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (!corps.getCorpsPersons().contains(nowUser.getEmail())){
            corps.setCorpsPersons(corps.getCorpsPersons()+nowUser.getEmail()+":"+nowUser.getRealname()+";");
        }
        corps.setLeader(nowUser.getUsername());
        corps.setCorpsImage(img);
        boolean isSuccess=corpsService.insertCorps(corps);
        if (isSuccess){
            return ServerResponse.createBySuccessMessage("组建战队成功！");
        }else{
            return ServerResponse.createByErrorMessage("组建战队失败！");
        }
    }
    @RequestMapping("/getMyCorps")
    @ResponseBody
    public ServerResponse getMyCorps(HttpSession session){
        String myemail= ((User)session.getAttribute("nowUser")).getEmail();
        List<Corps> mycorps=corpsService.getMyCorps(myemail);
        return ServerResponse.createBySuccess(mycorps);
    }
    @RequestMapping("/signCorps")
    @ResponseBody
    public ServerResponse signCorps(int corpsid,int matchid){
        boolean isSuccess=corpsService.signCorps(corpsid,matchid);
        if (isSuccess){
            return ServerResponse.createBySuccessMessage("战队报名成功！");
        }else{
            return ServerResponse.createByErrorMessage("战队报名失败！");
        }
    }
    @RequestMapping("/reject")
    public ServerResponse reject(int id){
        boolean isSuccess=corpsService.setReject(id);
        if (isSuccess){
            return  ServerResponse.createBySuccess();
        }else
        {
            return ServerResponse.createByError();
        }
    }

    @RequestMapping("/pass")
    @ResponseBody
    public ServerResponse pass(int corpsid,int matchid){
        boolean isSuccess1=corpsService.setPass(corpsid);
//        boolean isSuccess2=corpsService.addEnters(corpsid,matchid);
        if (isSuccess1){
            return  ServerResponse.createBySuccess();
        }
        else
        {
            return ServerResponse.createByError();
        }
    }
    @RequestMapping("/checkin")
    @ResponseBody
    public Map<String,Object> corpshandle(int page, int limit){
        Map<String,Object> map=new HashMap<>();
        List<ExCorps> exCorps=corpsService.getCorps();
        PageHelper.startPage(page, limit);
        List<ExCorps> exCorps1=corpsService.getCorps();
        map.put("code",0);
        map.put("msg","");
        map.put("count",exCorps.size());
        map.put("data",exCorps1);
        return map;
    }

    @RequestMapping("/register")
    @ResponseBody
    public ServerResponse register(int corpsid,String score,String describe){
        boolean isSuccess=corpsService.updateCorps(corpsid,score,describe);
        if (isSuccess){
            return ServerResponse.createBySuccess();
        }else {
            return ServerResponse.createByError();
        }
    }
}
