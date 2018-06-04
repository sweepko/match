<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/11
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String info=request.getParameter("info");
%>
<html>
<head>
    <title>用户登录</title>

    <link rel="stylesheet" href="<%=path%>/static/css/global.css" media="all">
    <link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=path%>/static/css/todc-bootstrap.min.css"/>
    <style type="text/css">
        body{
            background:url("../images/grass.jpg") top center no-repeat;
            background-size:cover;
        }
        #login-form{
            margin-top: 50px;
        }

        #title {
            position: fixed;
            top: 50px;
            left: 100px;
            font-size: 40px;
        }

        #title-tail {
            position: fixed;
            top: 130px;
            left: 210px;
            font-size: 20px;
        }

        #login-div{
            margin-top: 50px;
        }

        h2{
            font-size: 30px;
            font-family: source_code_pro,"PingFangSC-Regular",
            "Heiti SC","Microsoft Yahei",monospace;
        }

        a{
            color: #428bca;
        }
    </style>
    <script src="<%=path%>/layui/layui.js"></script><link rel="shortcut icon" href="../images/five.jpg" />
</head>
<body>

<a href="<%=path%>/first/index.jsp">
    <p id="title">赛事管理平台</p>
    <p id="title-tail">join &nbsp;us</p>
</a>

<div id="login-div" class="container main">
    <div class="col-md-6 col-md-offset-3">
        <h2 class="text-center" style="color: #1a70fe;">管理员登录</h2>

        <form id="login-form" action="<%=path%>/admin/adminLogin.do" method="post">
            <div class="form-group">
                <label style="color: #1a70fe" for="username">用户名</label>
                <input type="text" class="form-control input-lg" id="username" name="username" maxlength="30"
                       data-error="请填写用户名" placeholder="用户名" autofocus required>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label style="color: #1a70fe" for="password">密码</label>
                <input type="password" class="form-control input-lg" id="password" name="password" maxlength="30"
                       data-error="请填写密码" placeholder="密码" required>

                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group" id="captcha-area">
                <label style="color: #1a70fe" for="captcha">验证码</label>&nbsp;&nbsp;
                <img style="cursor: pointer;" src="<%=path%>/verifyCode/produce.do" id="captcha-img">
                <small><p></p></small>
                <input type="text" class="form-control input-lg" id="captcha" name="captcha"
                       placeholder="验证码" maxlength="4" data-error="请填写验证码" required>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">提交</button>
            </div>
        </form>
    </div>
</div>
<jsp:include page="../WEB-INF/base/footer.jsp"></jsp:include>


<script>
    layui.use('layer', function(){
        var layer = layui.layer;
        var $=layui.jquery;
        //显示信息
        var info=<%=info%>;
        if (info==0){
            layer.alert("用户名或密码输入错误!");
        }else if (info==1){
            layer.alert("验证码输入错误！");
        }

        $("#captcha-img").click(function () {
            $("#captcha-img").attr("src","<%=path%>/verifyCode/produce.do?"+Math.random());
        });


    });

</script>

</body>
</html>
