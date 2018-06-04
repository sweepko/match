<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/3/26
  Time: 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>用户列表</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/default.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/styles.css">
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
</head>
<body>
<div class='title'>
    <div class='title_inner'>
        <h1>
            Funky fresh inbox UI
        </h1>
        <h2>
            Just messing around with some concepts for a UI... and this is what i ended up with! Pure css goodness!
        </h2>
    </div>
</div>
<div class='container' style="margin-left: 70px;">
    <div class='container_ui' style="height:450px;width:780px;overflow-y: auto;">
        <div class='container_ui__heading' style="width: 350px;">
            <div class='header_icon'>
                <img style="margin-top:5px;" width="70" src='<%=path%>/images/ludalogo.png'>
            </div>
            <h1>
                用户列表
            </h1>
            <div class='menu_icon'>
                <div class='div'></div>
                <div class='div'></div>
                <div class='div'></div>
            </div>
        </div>

        <c:forEach items="${users}" var="item" varStatus="i">
        <input id='message-${i.index}' type='checkbox'>
        <label for='message-${i.index}' href='#move'>
            <div class='container_ui__item' style="width: 350px;">
                <div class='face'>
                    <img  width="100" src='<%=path%>/image/${item.userimage}'>
                    <div class='color_bar one'>
                        <p>${item.username}简介</p>
                        <span>名片</span>
                    </div>
                </div>
                <h2>
                    ${item.username}
                </h2>
                <div class='dot active'></div>
                <h3>性别: ${item.sex}</h3>
                <h4>年龄: ${item.age}</h4>
            </div>

            <div class='container_ui__expand' id='close'>
                <div class='heading'>
                    <div class='heading_head'>
                     <a  style="position:absolute;margin-right: 25px;margin-top: 23px;" >
                         <i onclick="download(this)" userid="${item.userid}" class="layui-icon">&#xe601;</i>
                     </a>
                    </div>
                    <label for='message-${i.index}'>
                        x
                    </label>

                </div>
                <div class='body'>
                    <div class='user'>
                        <div class='face'>
                            <img width="80" src='<%=path%>/image/${item.userimage}'>
                        </div>
                        <div class='details'>
                            <h2>${item.realname}</h2>
                            <h3>email: ${item.email}</h3>
                        </div>
                    </div>

                    <div class='content'>
                        <p><b>个性签名</b></br>${item.motto}</p>
                    </div>
                </div>
            </div>
        </label>
        </c:forEach>

    </div>
</div>
<script src="<%=path%>/js/jquery-3.2.1.min.js"></script>
<script src="<%=path%>/layui/layui.js"></script>

<script>
        function download(cell) {
            var userid=cell.getAttribute("userid")
            alert("文档下载成功，请在D：download目录下查看！")
            $.ajax({
                type:'post',
                url:'<%=path%>/word/downWord.do',
                data:{userid:userid},
                success:function (response) {
                    if (response.status=="0"){
                        alert("文档下载成功，请在D：download目录下查看！")
                    }
                }
            })
        }

</script>
</body>

</html>
