package com.sweep.controller;

import com.github.pagehelper.PageHelper;
import com.sweep.common.ServerResponse;
import com.sweep.pojo.CrawMatch;
import com.sweep.pojo.Match;
import com.sweep.service.CrawService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 爬虫赛事操作
 */
@Controller
@RequestMapping("/craw")
public class CrawController {
    @Autowired
    private CrawService crawService;
    @RequestMapping("/getAllCraw")
    public void getAllCraw(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CrawMatch> crawMatches=crawService.getAllCraw();
        request.setAttribute("craw",crawMatches);
        request.getRequestDispatcher(request.getContextPath()+"/frames/admin/home.jsp").forward(request,response);
    }

    @RequestMapping("/userGetAllCraw")
    public String userGetAllCraw(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CrawMatch> crawMatches=crawService.getCraw("");
        request.setAttribute("craw",crawMatches);
        return "forward:"+request.getContextPath()+"/frames/user/home.jsp";
    }

    @RequestMapping("/lookCraw")
    @ResponseBody
    public Map<String,Object> getcraw(int page,int limit,@RequestParam(value = "keyword",required = false) String keyword){
        Map<String,Object> map=new HashMap<>();
        List<CrawMatch> crawMatches1=crawService.getCraw(keyword);
        PageHelper.startPage(page, limit);
        List<CrawMatch> crawMatches2=crawService.getCraw(keyword);
        map.put("code",0);
        map.put("msg","");
        map.put("count",crawMatches1.size());
        map.put("data",crawMatches2);
        return map;
    }

    @RequestMapping("/crawDelete")
    @ResponseBody
    public ServerResponse crawDelete(String ids){
        int code=crawService.deleteCrawMatches(ids);
        if (code>0){
            return ServerResponse.createBySuccessMessage("赛事新闻删除成功");
        }else{
            return ServerResponse.createByErrorMessage("赛事新闻删除失败");
        }
    }

}
