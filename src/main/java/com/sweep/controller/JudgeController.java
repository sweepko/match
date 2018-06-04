package com.sweep.controller;

import com.sweep.common.ServerResponse;
import com.sweep.pojo.Judge;
import com.sweep.pojo.User;
import com.sweep.service.JudgeService;
import net.sf.jsqlparser.schema.Server;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
@RequestMapping("/judge")
public class JudgeController {
    @Autowired
    private JudgeService judgeService;
    @RequestMapping("/getAllJudge")
    @ResponseBody
    public Map<String, Object> getAllJudges(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Judge> judges=judgeService.selectAllJudge();
        Map<String,Object>  map=new HashMap<>();
        map.put("code",0);
        map.put("msg","");
        map.put("count",judges.size());
        map.put("data",judges);
        return map;
    }

    /**
     * 修改裁判信息
     * @param judge
     * @return
     */
    @RequestMapping("/updateJudge")
    @ResponseBody
    public  ServerResponse updateJudge(Judge judge){
        boolean isSuccess=judgeService.updateByPrimaryKeySelective(judge);
        if (isSuccess){
            return ServerResponse.createBySuccess();
        }else{
            return ServerResponse.createByError();
        }
    }
    @RequestMapping("/delJudge")
    @ResponseBody
    public ServerResponse delJudge(Judge judge){
        boolean isSuccess=judgeService.delJudgeByPrimaryKey(judge.getJudgeid());
        if (isSuccess){
            return ServerResponse.createBySuccess();
        }else{
            return ServerResponse.createByError();
        }
    }
    @RequestMapping("/getjudge")
    public void getjudge(Model model,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        List<Judge> judges=judgeService.selectAllJudge();
        request.setAttribute("judges",judges);
        request.getRequestDispatcher(request.getContextPath()+"/frames/admin/addmatch.jsp").forward(request,response);
    }

    @RequestMapping("/addjudge")
    @ResponseBody
    public ServerResponse addjudge(HttpSession session,Judge judge){
        User nowUser= (User) session.getAttribute("nowUser");
        judge.setJudgename(nowUser.getUsername());
        judge.setJudgeage(nowUser.getAge());
        judge.setJudgeemail(nowUser.getEmail());
        judge.setJudgeimage(nowUser.getUserimage());
        judge.setJudgesex(nowUser.getSex());
        boolean isSuccess=judgeService.addJudge(judge);
        if (isSuccess){
            return ServerResponse.createBySuccessMessage("申请请求已发送！");
        }else {
            return ServerResponse.createByErrorMessage("申请请求发送失败！");
        }
    }

}
