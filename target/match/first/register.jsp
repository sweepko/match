<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/10
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>用户注册</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/crowd.css">
    <style>
        .success
        {
            background-image: url("<%=path%>/images/li_ok.gif");
            background-color:#E6FEE4;
            border-color:#01BE00;
            background-repeat: no-repeat;
            background-position: left 2px;
            padding:0 18px;
        }
        .danger
        {
            background-image: url("<%=path%>/images/li_err.gif");
            background-color:#FFF2E5;
            border-color:#FF3300;
            background-repeat: no-repeat;
            background-position: left 2px;
            padding:0 18px;
        }
        .nav
        {
            width: 650px;
            margin: 50px auto;
        }
        .nav1
        {
            border: 1px solid #666666;
            border-radius: 5px;
        }
        label
        {
            width: 150px;
            height: 30px;
            line-height: 30px;
            text-align: right;
            font-size: 14px;
            display: inline-block;
        }
        span
        {
            background-color:#FFFFDA ;
            border: 1px solid #FFCD00;
            font-size: 12px;
            height: 20px;
            line-height: 20px;
            display: inline-block;
            margin-left: 40px ;

        }
        button
        {
            margin-left: 159px;
            border: dashed 1px transparent;
            background-color: transparent;
            cursor: pointer;
        }
    </style>

</head>
<body style="background-color: #666666">
<header style="position: absolute;z-index: -1">
    <div class="bg">
        <canvas id="display" width="1366" height="637" style="width: 1366px; height: 637px;"></canvas>
        <div id="blachole"></div>
    </div>

</header>
<div class="nav">
    <div>
        <img style="position: absolute;left: 100px;top:200px;" width="350" src="../images/riot1.png">
    </div>
    <h2 style="font-family: 'Adobe 仿宋 Std R';" align="center">赛事管理平台</h2>
    <br>
    <div class="nav1">
        <form action="<%=path%>/user/userRegister.do" method="post">
            <p>
                <label for="NC">用户名：</label>
                <input type="text" name="username" id="NC" onblur="checkNC()"><span>请输入昵称</span>
            </p>
            <br>

            <p>
                <label for="passWord">密码：</label>
                <input type="password" name="password" id="passWord" onblur="checkPassWord()"> <span>密码为6-16位</span>
            </p>
            <br>
            <p>
                <label for="rePassWord">确认密码：</label>
                <input type="password" id="rePassWord" onblur="checkRePassWord()"><span>请再次输入密码</span>
            </p><br>
            <p>
                <label>性别：</label>
                <input type="radio" name="sex" value="男" checked>男
                <input type="radio" name="sex" value="女">女
            </p><br>
            <p>
                <label for="age">年龄：</label>
                <input type="text" name="age" id="age" onblur="checkAge()"><span>请输入年龄</span>
            </p><br>
            <p>
                <label for="name">真实姓名：</label>
                <input type="text" id="name" name="realname" onblur="checkName()"><span>请输入您的真实姓名</span>
            </p><br>

            <p>
                <label for="tel">手机号:</label>
                <input type="text" id="tel" name="phone" onblur="checkTel()"><span>请输入关联手机号</span>
            </p><br>
            <p>
                <label for="email">邮箱：</label>
                <input type="text" id="email" name="email" onblur="checkEmail()"><span>请输入保密邮箱</span>
            </p><br>
            <button type="submit" style="margin-left:150px;">
            <img src="<%=path%>/images/button.gif">
            </button>
        </form>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<%=path%>/js/constellation.js"></script>
<script>
            var form = document.querySelector('form');
            var name = document.getElementById('name');//真实姓名
            var passWord = document.getElementById('passWord');
            var rePassWord = document.getElementById('rePassWord');
            var NC = document.getElementById("NC");//昵称
            var tel = document.querySelector('#tel');
            var email = document.querySelector('#email');
            var span = document.querySelectorAll('span');
            var ages=document.querySelector('#age');
            //onsubmit事件
            form.onsubmit = function (e) {
                var flag=true;
                var username = checkUserName();
                if (!username) {
                    flag=false;
                }
                var password = checkPassWord();
                if (!password) {
                    flag=false;
                }
                var rePassWord = checkRePassWord();
                if (!rePassWord) {
                    flag=false;
                }

                var age=checkAge();
                if (!age){
                    flag=false;
                }

                var name = checkName();
                if (!name) {
                    flag=false;
                }
                var NC = checkNc();
                if (!NC) {
                    flag=false;
                }
                var tel = checkTel();
                if (!tel) {
                    flag=false;
                }
                var email = checkEmail();
                if (!email) {
                    flag=false;
                }
                <%--if (flag){--%>
                    <%--$.ajax({--%>
                        <%--type:"post",--%>
                        <%--url:"<%=path%>/user/userRegister.do",--%>
                        <%--data:{nc:$("#NC").val(),name:$("#name").val(),--%>
                            <%--password:$("#password").val(),sex:$("#sex").val(),},--%>
                        <%--datatype:"json",--%>
                        <%--success:function (response) {--%>
                            <%--alert(response);--%>
                        <%--},--%>
                        <%--error:function(xhr,textState){--%>
                            <%--alert("数据请求失败");--%>
                        <%--}--%>
                        <%----%>
                    <%--});--%>
                <%--}--%>
                return flag;
            }

//---------------------------------函数封装-------------------------------------------------------------
            //登录密码
            function checkPassWord(e) {
                if (passWord.value.length == 0) {
                    span[1].innerText = '密码不能为空';
                    span[1].className = 'danger';
                    return false;
                }
                var pattern = /^[A-Za-z0-9]{6,16}$/;
                if (!pattern.test(passWord.value)) {
                    span[1].innerText = '密码不符合格式，请重新输入';
                    span[1].className = 'danger';
                    return false;
                }
                span[1].innerText = '密码输入正确';
                span[1].className = 'success';
                return true;
            }



            //重复登录密码
            function checkRePassWord(e) {
                if (rePassWord.value.length == 0) {
                    span[2].innerText = '重复密码不能为空';
                    span[2].className = 'danger';
                    return false;
                }
                if (rePassWord.value != passWord.value) {
                    span[2].innerText = '两次输入的密码不一致，请重新输入';
                    span[2].className = 'danger';
                    return false;
                }
                span[2].innerText = '两次密码一致';
                span[2].className = 'success';
                return true;
            }

            function checkAge() {
                if(ages.length==0){
                    span[3].innerText = '年龄不能为空';
                    span[3].className = 'danger';
                    return false;
                }
                span[3].innerText = '年龄输入正确';
                span[3].className = 'success';
                return true;
            }

            //真实姓名（2-4位汉字）
            function checkName() {
                if ($('#name').val().length==0) {
                    span[4].innerText = '真实姓名不能为空';
                    span[4].className = 'danger';
                    return false;
                }
                var pattern = /^[\u4e00-\u9fa5]{2,4}$/;
                if (!pattern.test($("#name").val())) {
                    span[4].innerText = '真实姓名格式错误，请重新输入';
                    span[4].className = 'danger';
                    return false;
                }
                span[4].innerText = '真实姓名输入正确';
                span[4].className = 'success';
                return true;
            }

            //昵称（6-20位所有字符）
            function checkNC() {
                var flag=true;
                if (flag&&NC.value.length == 0) {
                    span[0].innerText = '昵称不能为空';
                    span[0].className = 'danger';
                    flag=false;
                }
                var pattern = /^.{3,20}$/;
                if (flag&&!pattern.test(NC.value)) {
                    span[0].innerText = '昵称长度3-20位，请重新输入';
                    span[0].className = 'danger';
                    flag=true;
                }

                span[0].innerText = '昵称输入正确';
                span[0].className = 'success';
                return flag;
            }


            //手机号（）
            function checkTel(e) {
                if (tel.value.length == 0) {
                    span[5].innerText = '手机号不能为空';
                    span[5].className = 'danger';
                    return false;
                }
                var pattern = /^1[34578]\d{9}$/;
                if (!pattern.test(tel.value)) {
                    span[5].innerText = '手机号码格式错误，请重新输入';
                    span[5].className = 'danger';
                    return false;
                }
                span[5].innerText = '手机号输入正确';
                span[5].className = 'success';
                return true;
            }


            //邮箱
            function checkEmail(e) {
                if (email.value.length == 0) {
                    span[6].innerText = '邮箱不能为空';
                    span[6].className = 'danger';
                    return false;
                }
                var pattern = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                if (!pattern.test(email.value)) {
                    span[6].innerText = '邮箱格式错误，请重新输入';
                    span[6].className = 'danger';
                    return false;
                }
                span[6].innerText = '邮箱输入正确';
                span[6].className = 'success';
                return true;
            }
</script>
</body></html>