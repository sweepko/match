<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>赛事管理平台</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
    <link rel="shortcut icon" href="<%=path%>/images/five.jpg" />
    <style>
        html,body{
            overflow: hidden;
        }
        li:hover{
            cursor: pointer;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><img width="50" src="<%=path%>/images/ludalogo.png">赛事管理平台</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a id="handle">报名<span class="layui-badge" id="number">${number}</span></a></li>
            <li class="layui-nav-item"><a id="check">选手登记</a></li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    ${nowUser.adminUsername}
                </a>
                <dl class="layui-nav-child">
                    <dd><a id="lookAdmin">查看管理员</a></dd>
                    <dd><a id="addAdmin">添加管理员</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="<%=path%>/user/userExit.do">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item"><a id="index">首页</a></li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">赛事管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="lookmt">查看赛事</a></dd>
                        <dd><a id="addmt">发布赛事</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">新闻管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="looknews">查看新闻</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">人力管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="judge">裁判管理</a></dd>
                        <dd><a id="userdetail">用户详情</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">通告管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="addNotice">发布通告</a></dd>
                        <dd><a id="lookNotice">查看通告</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe id="iframe" src="<%=path%>/frames/over.jsp?param=1" name="frame" width="100%" height="100%">
        </iframe>

    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 鲁东大学软件工程系 - 率为朋
    </div>
</div>



<script src="<%=path%>/layui/layui.js"></script>
<script>

    layui.use('layer', function(){
        var element = layui.element;
        var $=layui.jquery;
        //跳转首页,需要过渡页
        $("#index").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=1");
        });
        //跳转查看赛事
        $("#lookmt").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/admin/lookmatch.jsp");
        });
        //发布赛事,需要过渡页
        $("#addmt").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=2")
        })
        //裁判管理
        $("#judge").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/admin/lookjudge.jsp");//查看所有裁判
        });
        //查看新闻
        $("#looknews").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/admin/looknews.jsp")
        })
        //发布通告
        $("#addNotice").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/admin/addnotice.jsp")
        })
        $("#lookNotice").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/admin/looknotice.jsp")
        })
        $("#handle").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/admin/handle.jsp")
        })
        $("#check").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/admin/checkin.jsp")
        })
        $("#userdetail").click(function () {
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=3")
        })
        //添加管理员
        $("#addAdmin").click(function () {
            layer.open({
                id:1,
                type: 1,
                title:'输入添加的用户名和密码',
                skin:'layui-layer-rim',
                area:['450px', 'auto'],

                content: ' <div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'
                +'<div class="col-sm-12">'
                +'<div class="input-group">'
                +'<span class="input-group-addon"> 用户名 :</span>'
                +'<input id="adminname" type="text" class="form-control" placeholder="请输入用户名">'
                +'</div>'
                +'</div>'
                +'<div class="col-sm-12" style="margin-top: 10px">'
                +'<div class="input-group">'
                +'<span class="input-group-addon">密码:</span>'
                +'<input id="adminpass" type="password" class="form-control" placeholder="请输入密码">'
                +'</div>'
                +'</div>'
                +'</div>'
                ,
                btn:['确认添加','取消'],
                btn1: function (index,layero) {
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/admin/addAdmin.do",
                        data:{adminUsername:$("#adminname").val(),adminPassword:$("#adminpass").val()},
                        datatype:"json",
                        success:function (response) {
                            if (response.status=="0"){
                                layer.msg("添加管理员成功！",{icon:1});
                            }else{
                                layer.msg("添加管理员失败!",{icon:5})
                            }
                            layer.close(index);
                        }
                    });
                },
                btn2:function (index,layero) {
                    layer.close(index);
                }

            });
        });

        $("#lookAdmin").click(function () {

            var str="<div style=\"padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;\">"
            $.ajax({
                type:"get",
                url:"<%=path%>/admin/getAdmin.do",
                datatype:"json",
                success:function (response) {
                    var objs=response.data;
                    for (var i=0;i<objs.length;i++){
                        str+="<h2>"+objs[i].adminUsername+"</h2><br>"
                    }
                    str+="</div>"
                    layer.open({
                        type: 1
                        ,title: '管理员列表' //不显示标题栏
                        ,closeBtn: false
                        ,area:['200px', 'auto']
                        ,shade: 0.8
                        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                        ,btn: ['关闭']
                        ,btnAlign: 'c'
                        ,moveType: 1 //拖拽模式，0或者1
                        ,content:str
                        ,success: function(layero){
                            layer.close();
                        }
                    });
                }
            })
        });
    });
    layui.use('element', function(){
        var element = layui.element;

    });


</script>
</body>
</html>