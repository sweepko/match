<%@ page import="com.sweep.pojo.User" %>
<%@ page import="com.sweep.pojo.Admin" %><%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/11
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>Insert Title</title>
    <style type="text/css">
        #title {
            color: #fff;
        }

        #title-tail {
            color: #fff;
        }
    </style>
</head>
<body>
<a>
    <p id="title">赛事管理中心</p>
    <p id="title-tail">join &nbsp;us</p>
</a>

<%
    String div_style = "block";
    String is_online = "none";
    User user=null;
    Admin admin=null;
    // 获取普通的用户
    try {
        user = (User) session.getAttribute("nowUser");
    }catch (ClassCastException e){
        admin= (Admin) session.getAttribute("nowUser");
    }
    // 获取管理员
//    Object admin = session.getAttribute("adminName");
//    String adminName = (String) admin;
    String username=null;
    if (user != null) {
        username=user.getUsername();
        div_style = "none";
        is_online = "block";
    }else if (admin!=null){
        username=admin.getAdminUsername();
        div_style = "none";
        is_online = "block";
    }
    else{
        div_style = "block";
        is_online = "none";
    }
%>

<div id="login" style="display: <%=div_style%>">
    <a href="<%=path%>/first/user_login.jsp">
        <button class="btn btn-success btn-lg">
            登录
        </button>
    </a>
    <a href="<%=path%>/first/register.jsp">
        <button class="btn btn-warning btn-lg">
            注册
        </button>
    </a>
</div>

<div id="login" style="display: <%=is_online%>">
        <button class="btn btn-success btn-lg">
            <%=username%>
        </button>
    <a href="<%=path%>/user/userExit.do">
        <button class="btn btn-warning btn-lg">
            退出登录
        </button>
    </a>
</div>

<%--<div id="login" style="display: <%=admin_login%>">--%>
    <%--<a href="index.jsp">--%>
        <%--<button class="btn btn-success btn-lg">--%>
            <%--&lt;%&ndash;<%=adminName%>&ndash;%&gt;sweep--%>
        <%--</button>--%>
    <%--</a>--%>
    <%--<a href="user-exit">--%>
        <%--<a class="btn btn-warning btn-lg">--%>
            <%--退出登录--%>
        <%--</a>--%>
    <%--</a>--%>
<%--</div>--%>
</body>
</html>
