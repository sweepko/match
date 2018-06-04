<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/20
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>找回密码</title>
    <link rel="shortcut icon" href="<%=path%>/images/five.jpg" />
    <link rel="stylesheet" href="<%=path%>/static/css/global.css" media="all">
    <link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=path%>/static/css/todc-bootstrap.min.css"/>

    <style type="text/css">

        body{
            background:url("<%=path%>/images/grass.jpg") top center no-repeat;
            background-size:cover;
        }

        #reset-div{
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

</head>
<body>

<a href="<%=path%>/first/index.jsp">
    <p id="title">赛事管理平台</p>
</a>

<div id="reset-div" class="container main">

    <div class="col-md-6 col-md-offset-3">
        <h2 style="color: #077ce0" class="text-center">找回密码</h2><br>

        <div>
            <p style="color: #1a70fe">请输入你注册时使用的邮箱地址，系统将自动向你的邮箱发送一封含有您登录信息的电子邮件，
                可以选择重新设置登录密码，注意为了你的账户安全，重置密码链接仅在30分钟内有效
            </p>
        </div>
        <br>
        <form id="login-form">
            <div class="form-group">
                <label for="ema" style="color: #077ce0">输入电子邮件地址</label>
                <input type="text" class="form-control input-lg" id="ema" placeholder="邮箱地址">

                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group" id="captcha-area">
                <label for="captcha" style="color: #1a70fe;">验证码</label>&nbsp;&nbsp;
                <img style="cursor: pointer;" src="<%=path%>/verifyCode/produce.do" id="captcha-img">
                <small><p></p></small>
                <input type="text" class="form-control input-lg" id="captcha" name="captcha"
                       placeholder="验证码" maxlength="4" data-error="请填写验证码">
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <a id="sub" class="btn btn-primary">提交</a>
            </div>

            <a href="<%=path%>/first/user_login.jsp">点击这里/返回登录</a>

        </form>
    </div>
</div>

<script src="<%=path%>/layui/layui.js"></script>
<script>
    layui.use('layer',function () {
        var layer=layui.layer;
        var $=layui.jquery;

        $("#captcha-img").click(function () {
            $("#captcha-img").attr("src","<%=path%>/verifyCode/produce.do?"+Math.random());
        });
        $("#sub").click(function () {
            var email=$("#ema").val();
            var captcha=$("#captcha").val();
            var pattern = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            if (!pattern.test(email)){
                layer.alert("请输入正确的邮箱格式！");
            }else if (captcha==null && captcha==""){
                layer.alert("请输入验证码");
            }else{
                $.ajax({
                    type:"post",
                    url:"<%=path%>/user/searchPass.do",
                    data:{email:email,captcha:captcha},
                    datatype:"json",
                    success:function (response) {
                        alert(response.msg);
                        if (response.status=="0"){
                            layer.prompt(function(value, index, elem){
                                $.ajax({
                                    type:"get",
                                    url:"<%=path%>/user/validateEmail.do",
                                    data:{code:value},
                                    success:function (data) {
                                        if (data=="1"){
                                            layer.open({
                                                id:1,
                                                type: 1,
                                                title:'修改密码',
                                                skin:'layui-layer-rim',
                                                area:['450px', 'auto'],
                                                content: ' <div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'
                                                +'<div class="col-sm-12">'
                                                +'<div class="input-group">'
                                                +'<span class="input-group-addon"> 新 密 码   :</span>'
                                                +'<input id="firstpwd" type="password" class="form-control" placeholder="请输入密码">'
                                                +'</div>'
                                                +'</div>'
                                                +'<div class="col-sm-12" style="margin-top: 10px">'
                                                +'<div class="input-group">'
                                                +'<span class="input-group-addon">确认密码:</span>'
                                                +'<input id="secondpwd" type="password" class="form-control" placeholder="请再输入一次密码">'
                                                +'</div>'
                                                +'</div>'
                                                +'</div>'
                                                ,
                                                btn:['保存','取消'],
                                                btn1: function (index,layero) {
                                                    if ($("#firstpwd").val()!=$("#secondpwd").val()){
                                                        layer.msg('两次密码输入不一致！', {icon: 5});
                                                    }else{
                                                        $.ajax({
                                                            type:"post",
                                                            url:"<%=path%>/user/resetPass.do",
                                                            data:{password:$("#firstpwd").val()},
                                                            success:function (data) {
                                                                layer.alert(data);
                                                            }
                                                        });
                                                    }
                                                    layer.close(index);
                                                },
                                                btn2:function (index,layero) {
                                                    layer.close(index);
                                                }
                                            });
                                        }else{
                                            layer.alert("校验码输入错误！");
                                        }
                                    }
                                });
                                layer.close(index);
                            });



                        }
                    }
                });
            }
        });


    });




</script>

</body>
</html>