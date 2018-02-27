<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/2/26
  Time: 12:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>用户首页</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css" media="all">
    <style>
        .matches{
            width: 700px;
            margin-left: 200px;
        }
        .textt{
            width: 480px;
            margin-left: 220px;
            display: inline-block;
        }
        .imagee{
            position: absolute;
            display: inline-block;
        }
    </style>
</head>
<body>

<div class="layui-carousel" id="test1">
    <div carousel-item>
        <div><img width="100%" src="<%=path%>/images/lb1.jpg"></div>
        <div><img width="100%" src="<%=path%>/images/lb2.jpg"></div>
        <div><img width="100%" src="<%=path%>/images/lb3.jpg"></div>
        <div><img width="100%" src="<%=path%>/images/lb4.jpg"></div>
        <div><img width="100%" src="<%=path%>/images/lb5.jpg"></div>
    </div>
</div>

<%--循环列表--%>
<div class="matches">
    <ul>
        <c:forEach items="${craw}" varStatus="i" var="item">
        <li style="position: relative;display: inline-block;width: 100%;">
            <hr style="margin-bottom: 20px;">
            <div>
                <div class="imagee"><img width="160" src="${item.crawImage}"></div>
                <div class="textt">
                    <a href="${item.crawContent}"><h2>${item.crawTitle}</h2></a>
                    <br>
                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${item.crawDesc}</p>
                    <br>
                    <div style=""><img width="30" src="<%=path%>/images/five.jpg"><span>${item.crawTime}</span></div>
                </div>
            </div>
        </li>
        </c:forEach>
    </ul>
</div>

<script src="<%=path%>/layui/layui.js"></script>
<script>
    layui.use('layer', function() {
        var element = layui.element;
        var $ = layui.jquery;
        //跳转首页,需要过渡页
        $("#index").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=6");
        });
    });
</script>
<script>
    layui.use('carousel', function(){
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            ,width: '100%' //设置容器宽度
            ,height: '400px'
            ,arrow: 'always' //始终显示箭头
            //,anim: 'updown' //切换动画方式
        });
    });
</script>
</body>
</html>
