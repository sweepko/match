<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/10
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>赛事管理平台</title>
    <!-- CSS 样式 -->
    <link rel="stylesheet" href="<%=path%>/static/css/style3.css" media="all">

    <!-- CSS 样式部分引用 -->
    <link rel="stylesheet" href="<%=path%>/static/css/global.css" media="all">
    <link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">
    <!-- JS 部分引用 -->
    <script type="text/javascript" src="<%=path%>/static/js/jquery.js"></script>
    <script type="text/javascript" src="<%=path%>/static/js/carousel.js"></script>

    <link rel="shortcut icon" href="<%=path%>/images/five.jpg" />
</head>
<body>
<div id="carousel-generic" class="carousel slide" data-ride="carousel"
     data-interval="1500">
    <!-- Wrapper for slides -->
    <div id="carousel" class="carousel-inner">
        <div class="item active">
            <img width="100%" src="<%=path%>/images/match_bg1.jpg" alt="...">
            <div class="carousel-caption">
                <jsp:include page="../WEB-INF/base/index_content.jsp"></jsp:include>
                <h1>赛事管理系统</h1>
                <p>
                    <img width="200" src="<%=path%>/images/ludalogo.png">
                </p>
            </div>
        </div>
        <div class="item">
            <img width="100%" src="<%=path%>/images/match_bg2.jpg" alt="...">
            <div class="carousel-caption">
                <jsp:include page="../WEB-INF/base/index_content.jsp"></jsp:include>
                <h1>赛事管理系统</h1>
                <p>
                    <img width="200" src="<%=path%>/images/ludalogo.png">
                </p>
            </div>
        </div>
        <div class="item">
            <img width="100%" src="<%=path%>/images/match_bg3.jpg" alt="...">
            <div class="carousel-caption">
                <jsp:include page="../WEB-INF/base/index_content.jsp"></jsp:include>
                <h1>赛事管理系统</h1>
                <p>
                    <img width="200" src="<%=path%>/images/ludalogo.png">
                </p>
            </div>
        </div>
        <div class="item">
            <img width="100%" src="<%=path%>/images/match_bg4.jpg" alt="...">
            <div class="carousel-caption">
                <jsp:include page="../WEB-INF/base/index_content.jsp"></jsp:include>
                <h1>赛事管理系统</h1>
                <p>
                    <img width="200" src="<%=path%>/images/ludalogo.png">
                </p>
            </div>
        </div>
        <div class="item">
            <img width="100%" src="<%=path%>/images/match_bg5.jpg" alt="...">
            <div class="carousel-caption">
                <jsp:include page="../WEB-INF/base/index_content.jsp"></jsp:include>
                <h1>赛事管理系统</h1>
                <p>
                    <img width="200" src="<%=path%>/images/ludalogo.png">
                </p>
            </div>
        </div>
    </div>
</div>

<!-- 以下为链接部分 -->
<div class="header-bottom-grids text-center">
    <a href="<%=path%>/admin/firstadmin.do">
        <div class="header-bottom-grid1">
            <span class="glyphicon glyphicon-leaf"></span>
            <h4>管理中心</h4>
        </div>
    </a>

    <a href="<%=path%>/user/firstuser.do">
        <div class="header-bottom-grid2">
            <span class="glyphicon glyphicon-certificate"></span>
            <h4>赛事首页</h4>
        </div>
    </a>

    <a href="<%=path%>/user/firstuser.do">
        <div class="header-bottom-grid3">
            <span class="glyphicon glyphicon-tree-deciduous"></span>
            <h4>用户入口</h4>
        </div>
    </a>

    <a href="<%=path%>/first/about.jsp">
        <div class="header-bottom-grid4">
            <span class="glyphicon glyphicon-screenshot"></span>
            <h4>关于我们</h4>
        </div>
    </a>
    <div class="clearfix"></div>
</div>
<jsp:include page="../WEB-INF/base/footer.jsp"></jsp:include>

</body>
</html>
