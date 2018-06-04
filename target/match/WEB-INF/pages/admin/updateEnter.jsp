<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/3/21
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>录入选手比赛结果</legend>
</fieldset>
<form class="layui-form" action="">
    <div class="layui-inline">
        <label class="layui-form-label">成绩</label>
        <div class="layui-input-inline">
            <input type="tel" name="score"  autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">描述</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>
</form>


</body>
</html>
