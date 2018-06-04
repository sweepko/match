<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/3/7
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
    String param=request.getParameter("param");
%>
<html>
<head>
    <title>通告</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
    <script src="<%=path%>/layui/layui.js"></script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
    <legend>通告</legend>
</fieldset>
<div class="layui-collapse" lay-accordion="">
    <c:forEach items="${notices}" var="item" varStatus="i">
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">${item.noticetitle}<span style="float: right;">${item.noticedate}</span></h2>
        <div class="layui-colla-content ">
            <p>&nbsp;&nbsp;&nbsp;
            ${item.noticecontent}
            <p>
        </div>
    </div>
    </c:forEach>
</div>


<script>
    layui.use(['element', 'layer'], function(){
        var element = layui.element;
        var layer = layui.layer;
        //监听折叠
        element.on('collapse(test)', function(data){
            layer.msg('展开状态：'+ data.show);
        });
    });
</script>
</body>
</html>
