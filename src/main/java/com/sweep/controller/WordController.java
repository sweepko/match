package com.sweep.controller;

import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;

import com.sun.deploy.net.HttpResponse;
import com.sun.javafx.iio.ImageStorage;
import com.sweep.common.ServerResponse;
import com.sweep.pojo.User;
import com.sweep.service.UserService;
import com.sweep.utils.TimeUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import net.sf.jsqlparser.schema.Server;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/word")
public class WordController{
    private static final long serialVersionUID = 1L;
    private Map<String, Object> session;
    @Autowired
    private UserService userService;
    private Configuration configuration = new Configuration();;
    // 创建文档模板
    public void CreateDoc(Map<String, Object> dataMap, String fileName,HttpServletRequest request) throws FileNotFoundException{
        configuration.setDefaultEncoding("utf-8");

        /* 得到当前上下文绝对路径 */
        String contextPath = request.getSession().getServletContext().getRealPath("\\");

        System.out.println("contextPath --- " +  contextPath);

        try {
            configuration.setDirectoryForTemplateLoading(new File(contextPath + "\\template"));
        } catch (IOException e1) {
            e1.printStackTrace();
        }

        Template template = null;

        try {
            template = configuration.getTemplate("user.ftl");
        } catch (Exception e) {
            System.out.println("template : " + e);
        }

        File outFile = new File(fileName);
        Writer out = null;
        FileOutputStream fos=null;
        OutputStreamWriter oWriter=null;
        try {
            fos = new FileOutputStream(outFile);
            oWriter = new OutputStreamWriter(fos, "UTF-8");
            out = new BufferedWriter(oWriter);
        } catch (Exception e) {
            System.out.println("fos : " + e);
        }

        try {
            template.process(dataMap, out);
            out.close();
            oWriter.close();
            fos.close();
        } catch (TemplateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    // 装填数据
    public Map<String, Object> handle_dataMap(User user,HttpServletRequest request){
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("username", user.getUsername());
        dataMap.put("email", user.getEmail());
        dataMap.put("sex", user.getSex());
        dataMap.put("realname",user.getRealname());
        dataMap.put("age", user.getAge());
        dataMap.put("motto", user.getMotto());
        String imageStr= getImageStr(new File("D:\\picture\\"+user.getUserimage()));
        dataMap.put("image",imageStr);
        dataMap.put("phone", user.getPhone());
        return dataMap;
    }


    @RequestMapping("/downWord")
    @ResponseBody
    public ServerResponse fileList(int userid, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        User worduser=userService.selectById(userid);

        /* 得到文件保存的绝对路径 */
        String savePath = "D:\\download";

        File file = new File(savePath);

        if (!file.exists() && !file.isDirectory()) {
            System.out.println(savePath + "目录不存在，需要创建");
            file.mkdir();
        }

        // 以下为创建用户的详细信息表
            String filename = worduser.getUsername();

            String uploadFilePath = savePath + "\\" + filename +"用户详情介绍.doc";
            Map<String, Object> dataMap = handle_dataMap(worduser,request);
            try {
                CreateDoc(dataMap, uploadFilePath,request);
                downLoadFile(request,response,filename);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
          return ServerResponse.createBySuccess();
    }

    // 以下为文件的下载方法
    public void downLoadFile(HttpServletRequest request,HttpServletResponse response,String fileName) throws IOException {

        // 去除字符串的首尾空格
        fileName.trim();
        // 测试时使用
//		System.out.println("error --- fileName " + fileName);
//		System.out.println("utfFileName --- utfFileName " + utfFileName);

        /* 得到文件保存的绝对路径 */
        String fileSaveRootPath = "D:\\download";

        File file = new File(fileSaveRootPath+ "\\" + fileName+"用户详情介绍.doc");

        if(!file.exists()){
            request.setAttribute("message", "您要下载的资源已被删除！！");
        }

        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(file.getName(), "UTF-8"));
        FileInputStream in = new FileInputStream(file);
        OutputStream out = response.getOutputStream();
        byte buffer[] = new byte[1024];
        int len = 0;
        while((len=in.read(buffer))>0){
            out.write(buffer, 0, len);
        }
        in.close();
        out.close();
    }

    private String getImageStr(File file) {
        InputStream in = null;
        byte[] data = null;
        try {
            in = new FileInputStream(file);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String imageCodeBase64 = Base64.encodeBase64String(data);
        return imageCodeBase64;
    }

}
