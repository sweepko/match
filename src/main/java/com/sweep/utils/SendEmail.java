package com.sweep.utils;

        import org.apache.velocity.Template;
        import org.apache.velocity.VelocityContext;
        import org.apache.velocity.app.VelocityEngine;
        import org.apache.velocity.runtime.RuntimeConstants;
        import org.apache.velocity.runtime.log.CommonsLogLogChute;
        import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;

        import java.io.StringWriter;
        import java.util.HashMap;
        import java.util.Map;

        import javax.servlet.http.HttpServletRequest;
        import javax.servlet.http.HttpSession;

public class SendEmail {

    private static final long serialVersionUID = 1L;


    public String jsonApplyResetPassword(String email,String username) {
        VelocityEngine ve = new VelocityEngine();
        ve.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
        ve.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
        // send Velocity log to SLF4J (via Commons Logging)
        ve.setProperty(VelocityEngine.RUNTIME_LOG_LOGSYSTEM_CLASS, CommonsLogLogChute.class.getName());
        // this allows unit tests to detect missing context vars:
        ve.setProperty("runtime.references.strict", true);
        ve.init();
        Template template = ve.getTemplate("template/emailTemplate.vm", "utf-8");
        VelocityContext ctx = new VelocityContext();

        // 生成六位随机字符串
        String chars = "0123456789";
        String randomNum = "";

        char[] rands = new char[6];

        for (int i = 0; i < 6; i++) {
            int rand = (int) (Math.random() * 10);
            rands[i] = chars.charAt(rand);
            randomNum += rands[i];
        }
        ctx.put("title", "赛事管理平台");
        ctx.put("username", username);
        ctx.put("randomNum", randomNum);

        StringWriter sw = new StringWriter();
        template.merge(ctx, sw);
        // 这个类主要是设置邮件
        MailSenderInfo mailInfo = new MailSenderInfo();
        mailInfo.setMailServerHost("smtp.qq.com");
        mailInfo.setMailServerPort("587");
        mailInfo.setValidate(true);
        mailInfo.setUserName("592438233@qq.com");

        // 开通smtp等服务时，设置你的邮箱授权码
        // 此时输入的为邮箱的授权码，而不是你的邮箱密码
        mailInfo.setPassword("edpxqdganucgbfge");
        mailInfo.setFromAddress("592438233@qq.com");
        mailInfo.setToAddress(email);
        mailInfo.setSubject("赛事管理平台密码找回~");
        mailInfo.setContent(sw.toString());

        // 这个类主要来发送邮件
        SimpleMailSender sms = new SimpleMailSender();

        SimpleMailSender.sendHtmlMail(mailInfo);// 发送html格式

        return randomNum;
    }

}

