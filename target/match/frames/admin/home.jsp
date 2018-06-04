<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/25
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../../css/reset.css">
    <link rel="stylesheet" href="<%=path%>/css/index.css"/>
    <script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
    <!--企业动态-->
    <script src="<%=path%>/js/jquery-ui-1.8.6.core.widget.js"></script>
    <script src="<%=path%>/js/jqueryui.bannerize.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            $('#banners').bannerize({
                shuffle: 1,
                interval: "5"
            });
            $(".ui-line").hover(function(){
                $(this).addClass("ui-line-hover");
                $(this).find(".ui-bnnerp").addClass("ui-bnnerp-hover");
            },function(){
                $(this).removeClass("ui-line-hover");
                $(this).find(".ui-bnnerp").removeClass("ui-bnnerp-hover");
            });
        });
    </script>
</head>
<body>
<div style="width: 1000px;height: 470px;margin: 20px auto;" class="banner">
<div class="warrper">
    <!--content-->
    <div class="content">
        <!--企业动态-->
        <div class="index-new w1200 mt30">
            <div class="indexadd mt50 mb60">
                <div id="banners" class="ui-banner">
                    <ul style="border: 2px;z-index: 99" class="ui-banner-slides">
                        <c:forEach items="${craw}" varStatus="i" var="item">
                        <li><a href="${item.crawContent}"><img src="${item.crawImage}" alt="${item.crawTitle}" title="${item.crawTitle}"/></a></li>
                        </c:forEach>
                    </ul><!--ui-banner-slides end-->
                    <ul class="ui-banner-slogans">
                        <c:forEach items="${craw}" varStatus="i" var="item">
                        <li class="ui-line">
                            <div class="ullinehover">
                                <div class="ui-bnnerimg floatLeft">
                                    <img src="${item.crawImage}" alt="item.crawTitle" width="103"/>
                                </div>
                                <div class="ui-bnnerp floatRight">
                                    <h3 style="margin-top: 8px;">${item.crawTitle}<span style="position:absolute;right: 200px;">${item.crawTime}</span></h3>
                                    <p>${item.crawDesc}
                                    </p>
                                </div>
                            </div>
                        </li>
                        </c:forEach>

                    </ul><!--ui-banner-slogans end-->
                </div>
            </div>
        </div>
        <!--企业动态 end-->
    </div>
    <!--content end-->

</div>
</div>
</body>
</html>
