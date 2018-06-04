package com.sweep.controller;

import com.github.pagehelper.PageHelper;
import com.sweep.common.ServerResponse;
import com.sweep.pojo.Judge;
import com.sweep.pojo.Match;
import com.sweep.pojo.User;
import com.sweep.service.EntersService;
import com.sweep.service.JudgeService;
import com.sweep.service.MatchService;
import com.sweep.utils.TimeUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/match")
public class MatchController {
    @Autowired
    private MatchService matchService;
    @Autowired
    private JudgeService judgeService;
    @Autowired
    private EntersService entersService;
    @RequestMapping("/addMatch")
    @ResponseBody
    public ServerResponse addMatch(@RequestParam(value = "image",required = false) MultipartFile image,Match match, HttpServletResponse response, HttpServletRequest request){

        String img="news_default.jpg";
        if (!image.isEmpty()){
            img= UUID.randomUUID()+image.getOriginalFilename();
            try {
                image.transferTo(new File("D:\\picture\\"+img));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        match.setMatchimage(img);
        match.setCreatedate(TimeUtil.getCurrentTime());
        System.out.println(match);
        int code=matchService.insertMatch(match);
        if (code>0){
//                response.sendRedirect(request.getContextPath()+"/frames/admin/lookmatch.jsp");
            return ServerResponse.createBySuccessMessage("赛事发布成功!");
        }else{
            return ServerResponse.createByErrorMessage("赛事发布失败！");
        }
    }

    @RequestMapping("/lookmatch.do")
    @ResponseBody
    public Map<String,Object> lookMatch(int page,int limit){
        Map<String,Object> map=new HashMap<>();
        List<Match> matches1=matchService.selectAllMatch();
        PageHelper.startPage(page, limit);
        List<Match> matches=matchService.selectAllMatch();
        map.put("code",0);
        map.put("msg","");
        map.put("count",matches1.size());
        map.put("data",matches);
        return map;
    }

    @RequestMapping("/uploadImg")
    @ResponseBody
    public Map<String,Object> upload(@Param("file") MultipartFile file){
        Map<String,Object> map=new HashMap<>();
        Map<String,Object> map2=new HashMap<>();
        String img="";
        if (!file.isEmpty()){
            img= UUID.randomUUID()+file.getOriginalFilename();
            try {
                file.transferTo(new File("D:\\picture\\"+img));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        map.put("code",0);//0表示成功，1失败
        map.put("msg","上传成功");//提示消息
        map2.put("src","/image/"+img);//图片url
        map2.put("title",img);//图片名称，这个会显示在输入框里
        map.put("data",map2);
        return map;
    }

    @RequestMapping("/matchDelete")
    @ResponseBody
    public ServerResponse deleteMatch(String ids){
        int code=matchService.deleteMatches(ids);
        if (code>0){
            return ServerResponse.createBySuccessMessage("赛事删除成功");
        }else{
            return ServerResponse.createByErrorMessage("赛事删除失败");
        }
    }
    @RequestMapping("/matchDetail")
    public String detailMatch(String matchid, Model model){
        Match match=matchService.selectMatchByPrimaryKey(Integer.parseInt(matchid));
        List<Judge> judges=judgeService.selectAllJudge();
        List<User> enters=entersService.selectEnters();
        model.addAttribute("enters",enters);
        model.addAttribute("match",match);
        model.addAttribute("judges",judges);
        return "pages/admin/matchdetail";
    }
    @RequestMapping("/updateMatch")
    @ResponseBody
    public ServerResponse updateMatch(@RequestParam(value = "image",required = false) MultipartFile image,Match match,HttpServletResponse response,HttpServletRequest request) throws IOException {
        System.out.println(match);
        String img="";
        if (!image.isEmpty()){
            img= UUID.randomUUID()+image.getOriginalFilename();
            try {
                image.transferTo(new File("D:\\picture\\"+img));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (!"".equals(img)){
            match.setMatchimage(img);
        }
        int code=matchService.updateMatch(match);
        if (code>0){
//            response.sendRedirect(request.getContextPath()+"/frames/admin/lookmatch.jsp");
            return ServerResponse.createBySuccessMessage("赛事信息修改成功！");
        }
        else{
            return ServerResponse.createByErrorMessage("赛事信息修改失败！");
        }
    }

    @RequestMapping("/lookAllMatch")
    public String lookAllMatch(HttpSession session){
        List<Match> matches1=matchService.selectAllMatch();
        session.setAttribute("matches",matches1);
        return "pages/user/lookmatches";
    }

    @RequestMapping("/selectMatch")
    @ResponseBody
    public ServerResponse selectMatch(String keyword,HttpSession session){
        List<Match> matches=matchService.selectMatchByKey(keyword);
        return ServerResponse.createBySuccess(matches);
    }

    @RequestMapping("/showMatch")
    public String showMatch(int matchid,Model model){
        Match match=matchService.selectMatchByPrimaryKey(matchid);
        model.addAttribute("match",match);
        return "pages/user/matchinfo";
    }

}
