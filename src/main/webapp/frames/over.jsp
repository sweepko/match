<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/25
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String param=request.getParameter("param");
%>
<html>
<head>
    <title>跳转页面</title>
    <script src="<%=path%>/layui/layui.js"></script>
</head>
<body>
跳转中
<%--管理员--%>
<form id="adminIndex" action="<%=path%>/craw/getAllCraw.do" method="get"></form>
<form id="getjudge" action="<%=path%>/judge/getjudge.do" method="get"></form>
<form id="userdetail" action="<%=path%>/user/getAllUser.do" method="get"></form>
<%--用户--%>
<form id="userIndex" action="<%=path%>/craw/userGetAllCraw.do" method="get"></form>
<form id="lookmatches" action="<%=path%>/match/lookAllMatch.do" method="get"></form>
<form id="alluser" action="<%=path%>/user/allUser.do" method="get"></form>
<form id="myinfo" action="<%=path%>/user/getMyMatch.do" method="get"></form>
<form id="notice" action="<%=path%>/notice/getNotice.do" method="get"></form>
<script>
    //JavaScript代码区域
    layui.use('layer', function(){
        var element = layui.element;
        var $=layui.jquery;
        layer.load(3);

        var param=<%=param%>;//取参数值
        if (param=="1"){ //跳转至管理员界面首页
            $("#adminIndex").submit()
        }
        else if (param=="2"){
            $("#getjudge").submit()
        }
        else if (param=="3"){
            $("#userdetail").submit()
        }
        else if (param=="6"){
            $("#userIndex").submit()
        }
        else if (param=="7"){
            $("#lookmatches").submit()
        }
        else if (param=="8"){
            $("#alluser").submit()
        }else if (param=="9"){
            $("#myinfo").submit()
        }else if (param=="10"){
            $("#notice").submit()
        }

    });
</script>
</body>
</html>
