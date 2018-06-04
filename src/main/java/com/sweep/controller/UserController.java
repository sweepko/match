package com.sweep.controller;

import com.sweep.common.ServerResponse;
import com.sweep.dao.UserMapper;
import com.sweep.pojo.Match;
import com.sweep.pojo.MyMatch;
import com.sweep.pojo.User;
import com.sweep.service.MatchService;
import com.sweep.service.UserService;
import com.sweep.utils.MD5_Encoding;
import com.sweep.utils.SendEmail;
import com.sweep.utils.TimeUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private MatchService matchService;
    @Autowired
    private MD5_Encoding md5_encoding;

    /**
     * 用户注册
     * @param user
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("/userRegister")
    public void userRegister(User user, HttpServletResponse response, HttpServletRequest request) throws IOException {
        user.setUserimage("default.png");
        user.setPassword(md5_encoding.getMD5ofStr(user.getPassword()));
        user.setCreateTime(TimeUtil.getCurrentTime());
        user.setCredit(100);
        boolean isSuccess=userService.insertUser(user);
        if (isSuccess){
            response.sendRedirect(request.getContextPath()+"/first/user_login.jsp");
        }else{
            response.sendRedirect(request.getContextPath()+"/first/register.jsp");
        }
    }

    /**
     * 用户登录
     * @param username
     * @param password
     * @param captcha
     * @param response
     * @param request
     * @throws IOException
     * @throws ServletException
     */
    @RequestMapping("/userLogin")
    public void userLogin(String username,String password,String captcha,HttpServletResponse response,HttpServletRequest request) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        captcha=captcha.toUpperCase();
        if (!captcha.equals(request.getSession().getAttribute("validateCode"))){
            response.sendRedirect(request.getContextPath()+"/first/user_login.jsp?info=1");//验证码输入错误
            return;
        }
        else{
            password=md5_encoding.getMD5ofStr(password);
            User currentUser=userService.selectUserByNameAndPass(username,password);
            if (currentUser!=null){
                request.getSession().setAttribute("nowUser",currentUser);
                request.getSession().setAttribute("power","0");//存储权限，0为普通用户
                request.getRequestDispatcher("../WEB-INF/pages/user/index.jsp").forward(request,response);
                return;
            }else {
                response.sendRedirect(request.getContextPath()+"/first/user_login.jsp?info=0");//用户找不到
                return;
            }
        }
    }

    @RequestMapping("/firstuser")
    public void firstuser(HttpSession session,HttpServletResponse response,HttpServletRequest request){
        Object object=session.getAttribute("nowUser");
        try {
            if (object instanceof User){
                request.getRequestDispatcher("../WEB-INF/pages/user/index.jsp").forward(request,response);
            }else
            {
                response.sendRedirect(request.getContextPath()+"/first/user_login.jsp");
            }
        }catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/mymatch")
    public void mymatch(HttpSession session,HttpServletResponse response,HttpServletRequest request){
        Object object=session.getAttribute("nowUser");
        try {
            if (object instanceof User){
                request.getRequestDispatcher("../WEB-INF/pages/user/myinfo.jsp").forward(request,response);
            }else
            {
                response.sendRedirect(request.getContextPath()+"/first/user_login.jsp");
            }
        }catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



    /**
     * 退出登录
     * @param session
     * @param response
     * @param request
     * @throws IOException
     */
    @RequestMapping("/userExit")
    public void userExit(HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException {
        session.removeAttribute("nowUser");
        response.sendRedirect(request.getContextPath()+"/first/index.jsp");
    }

    /**
     * 邮箱找回密码
     * @param email
     * @param captcha
     * @param session
     * @return
     */
    @RequestMapping("/searchPass")
    @ResponseBody
    public ServerResponse<String> searchPass(String email,String captcha,HttpSession session){
        //验证验证码
        captcha=captcha.toUpperCase();
        if (!captcha.equals(session.getAttribute("validateCode"))){
            return ServerResponse.createByErrorMessage("对不起，验证码输入错误");
        }
        //查询该邮箱是否存在对应的用户
        User user=userService.selectByEmail(email);
        if (user==null){
            return ServerResponse.createByErrorMessage("对不起，该邮箱未注册");
        }else{
            session.setAttribute("nowUser",user);
            SendEmail sendEmail=new SendEmail();
            String emailCode=sendEmail.jsonApplyResetPassword(email,user.getUsername());
            session.setAttribute("emailCode",emailCode);
            return ServerResponse.createBySuccessMessage("邮件发送成功，请注意查收！");
        }
    }

    /**
     * 根据userid修改密码
     * @param password
     * @param response
     * @param session
     * @throws IOException
     */
    @RequestMapping("/resetPass")
    public void resetPass(String password,HttpServletResponse response,HttpSession session) throws IOException {
        response.setCharacterEncoding("utf-8");
        User user= (User) session.getAttribute("nowUser");
        userService.updataPassByKey(md5_encoding.getMD5ofStr(password),user.getUserid());
        PrintWriter writer=response.getWriter();
        writer.write("密码修改成功");
        writer.flush();
        writer.close();
    }
    @RequestMapping("/validateEmail")
    public void validateEmail(String code,PrintWriter writer,HttpSession session){
        if (code.equals(session.getAttribute("emailCode"))){
            writer.write("1");//输入正确
        }else{
            writer.write("0");//输入错误
        }
        writer.flush();
        writer.close();
    }
    @RequestMapping("/allUser")
    public String allUser(Model model){
        List<User> users=userService.selectAllUser();
        model.addAttribute("users",users);
        return "pages/user/organize";
    }
    @RequestMapping("/getMyMatch")
    public String getMyMatch(Model model,HttpSession session){
        User user= (User) session.getAttribute("nowUser");
        List<MyMatch> mymatch=matchService.getMatchUserid(user.getUserid());

        model.addAttribute("mymatch",mymatch);
        return "pages/user/myinfo";
    }

    @RequestMapping("/uploadimage")
    @ResponseBody
    public Map<String,Object> upload(@Param("file") MultipartFile file,HttpSession session){
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
        User user= (User) session.getAttribute("nowUser");
        userService.updateImage(user.getUserid(),img);
        map.put("code",0);//0表示成功，1失败
        map.put("msg","上传成功");//提示消息
        map2.put("src","/image/"+img);//图片url
        map2.put("title",img);//图片名称，这个会显示在输入框里
        map.put("data",map2);
        return map;
    }

    @RequestMapping("/updateUser")
    @ResponseBody
    public ServerResponse updateUser(User user,HttpSession session,HttpServletRequest request){
        User nowUser= (User) session.getAttribute("nowUser");
        boolean idSuccess=userService.updateUser(nowUser.getUserid(),user);
        if (!idSuccess){
            return ServerResponse.createBySuccessMessage("信息修改失败！");
        }
        return ServerResponse.createByErrorMessage("信息修改成功！");
    }

    @RequestMapping("/getAllUser")
    public String getAllUser(Model model){
        List<User> users=userService.selectAllUser();
        model.addAttribute("users",users);
        return "pages/admin/userdetail";
    }



//    @RequestMapping(value = "/checkName",method = RequestMethod.POST)
//    public void checkName(String name, HttpServletResponse response){
//        response.setCharacterEncoding("utf-8");
//        PrintWriter writer=null;
//        try {
//            writer=response.getWriter();
//            User user=userMapper.selectByName(name);
//            if (user==null){
//                writer.write("0");
//            }else {
//                writer.write("1");
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }finally {
//            writer.flush();
//            writer.close();
//        }
//    }
}
