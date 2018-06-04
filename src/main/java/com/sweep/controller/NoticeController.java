package com.sweep.controller;

import com.github.pagehelper.PageHelper;
import com.sweep.common.ServerResponse;
import com.sweep.pojo.Admin;
import com.sweep.pojo.Match;
import com.sweep.pojo.Notice;
import com.sweep.service.NoticeService;
import com.sweep.utils.TimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    @Autowired
    private NoticeService noticeService;
    @RequestMapping("/addNotice")
    @ResponseBody
    public ServerResponse addNotice(Notice notice, HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
        Admin nowUser = (Admin) session.getAttribute("nowUser");
        notice.setNoticeperson(nowUser.getAdminUsername());
        notice.setNoticedate(TimeUtil.getCurrentTime());
        boolean isSuccess=noticeService.insertNotice(notice);
        if (isSuccess){
            return ServerResponse.createBySuccessMessage("通告发布成功！");
        }
        else {
            return ServerResponse.createByErrorMessage("通告发布失败！");
        }
    }

    @RequestMapping("/lookNotice.do")
    @ResponseBody
    public Map<String,Object> lookMatch(int page, int limit,@RequestParam(value = "keyword",required = false) String keyword){
        Map<String,Object> map=new HashMap<>();
        List<Notice> notices1=noticeService.selectNotice(keyword);
        PageHelper.startPage(page, limit);
        List<Notice> notices2=noticeService.selectNotice(keyword);
        map.put("code",0);
        map.put("msg","");
        map.put("count",notices1.size());
        map.put("data",notices2);
        return map;
    }

    @RequestMapping("/noticeDelete")
    @ResponseBody
    public ServerResponse noticeDelete(String ids){
        int code=noticeService.deleteNotices(ids);
        if (code>0){
            return ServerResponse.createBySuccessMessage("通告删除成功");
        }else{
            return ServerResponse.createByErrorMessage("通告删除失败");
        }
    }
    @RequestMapping("/selectNotice")
    public String selectNotice(int noticeid, Model model){
        Notice notice=noticeService.selectNoticeById(noticeid);
        model.addAttribute("notice",notice);
        return "pages/admin/changenotice";
    }
    @RequestMapping("/updateNotice")
    @ResponseBody
    public ServerResponse updateNotice(Notice notice){
        notice.setNoticedate(TimeUtil.getCurrentTime());
        boolean isSuccess=noticeService.updateNotice(notice);
        if (isSuccess){
            return ServerResponse.createBySuccessMessage("通告修改成功！");
        }else{
           return ServerResponse.createByErrorMessage("通告修改失败！");
        }
    }
    @RequestMapping("/getNotice")
    public String getNotice(Model model){
        List<Notice> notices=noticeService.getAllNotice();
        model.addAttribute("notices",notices);
        return "pages/user/looknotice";
    }

}
