<%@ page import="java.util.List" %>
<%@ page import="com.sweep.pojo.Match" %><%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/2/27
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
    List<Match> matches= (List<Match>) request.getSession().getAttribute("matches");
    System.out.println(matches.size());
%>
<html>
<head>
    <title>浏览赛事</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css" media="all">

    <style>
        * { margin: 0; padding: 0;}
        ul { list-style-type: none;}
        .keyword { display: block; width: 300px; margin: 0 auto 20px; padding: 8px; border: 1px solid #ccc;}
        .nav { width: 1000px; margin: 0 auto 20px; text-align: center; font-size: 0;}
        .nav li { display: inline-block; margin: 0 5px; padding: 10px 20px; font-size: 14px; color: #333; background-color: #ccc; cursor: pointer;}
        .nav .active { color: #fff; background-color: #21b384;}
        .jq22 { width: 1000px; margin: 0 auto; font-size: 0;}
        .filtr-item { display: inline-block; width: 230px; padding: 10px;}
        .filtr-item a { color: #444; text-decoration: none;}
        .filtr-item img { width: 100%; height: 131px;}
        .filtr-item span { display: block; margin-top: 5px; font-size: 12px; text-align: center;}

    </style>
    <script src="<%=path%>/js/jquery.min.js"></script>
    <script src="<%=path%>/js/jquery.filterizr.js"></script>
    <script>
        $(function() {
            $('.jq22').filterizr();

            $('.nav li').on('click', function() {
                $(this).toggleClass('active').siblings().removeClass('active');
            });
            $('#keyword').bind('input propertychange', function() {
                search($("#keyword").val())
            });
        });
        function detail(cell) {
            // 获取用户点击的matchid，进行显示跳转
            var matchid=$(cell).attr('matchid')
            $("#matchid").val(matchid)
            $("#showmatch").submit()
        }

        function search(param) {
            $.ajax({
                type:'get',
                url:'<%=path%>/match/selectMatch.do',
                data:{keyword:param},
                success:function (response) {
                    var objs=response.data;
                    var str=''
                    for (var i=0;i<objs.length;i++){
                        str+='<div class="filtr-item" data-category="1">\n' +
                            '        <a matchid='+objs[i].matchid+' onclick=detail(this)>\n' +
                            '        <img src="<%=path%>/image/'+objs[i].matchimage+'" alt="'+objs[i].matchname+'">\n' +
                            '            <span>'+objs[i].matchname+'</span>\n' +
                            '        </a>\n' +
                            '    </div>'
                        $("#banner").html(str)
                    }
                }
            });
        }
    </script>
</head>
<body>
<h1>近期赛事</h1>
<input class="keyword" id="keyword" placeholder="请输入关键字">
<ul class="nav">
    <li class="active" onclick="search('')">全部</li>
    <li  onclick="search('体育')">体育</li>
    <li  onclick="search('唱歌')">唱歌</li>
    <li  onclick="search('电子竞技')">电子竞技</li>
    <li  onclick="search('问答')">问答</li>
    <li  onclick="search('其他')">其他</li>
</ul>

<div class="jq22" id="banner">
    <%
        for (int i=0;i<matches.size();i++){
    %>
    <div class="filtr-item" data-category="1" style="cursor: pointer;">
        <a matchid="<%=matches.get(i).getMatchid()%>" onclick="detail(this)">
        <img src="<%=path%>/image/<%=matches.get(i).getMatchimage()%>" alt="<%=matches.get(i).getMatchname()%>">
            <span><%=matches.get(i).getMatchname()%></span>
        </a>
    </div>
    <%
        }
    %>
</div>



<%--辅助--%>
<form id="showmatch" action="<%=path%>/match/showMatch.do" method="post">
    <input type="hidden" name="matchid" id="matchid">
</form>















<style>
    h1 { margin: 40px auto; font: 32px "Microsoft Yahei"; text-align: center;}
</style>

<script src="<%=path%>/layui/layui.js" charset="UTF-8"></script>
<script>
    layui.use('layer',function () {
        var $=layui.$;


    });

</script>
</body>
</html>
