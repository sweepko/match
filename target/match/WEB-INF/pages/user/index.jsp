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
        #time{
            height: 50px;
            line-height: 50px;
            color: white;
            font-weight: bolder;
            font-size: 18px;
            position: absolute;
            top: 1px;
            right: 20px;
        }

        #music{
            width: 40px;
            height: 40px;
            margin: 5px 30px;
            /*参数一： 绑定keyfream上的名称 参数二：动画执行的时间 参数三：执行动画之前的延时 参数四：动画执行的次数
             参数五：动画的运动曲线 ease linear 参数六：动画是否反向执行
             * */
            animation: xuanzhuan 2s infinite ;
        }
        @keyframes xuanzhuan{
            from{
                transform: rotate(0deg);
            }
            to{
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body class="layui-layout-body">
<img style="position: absolute;margin-top: 350px;margin-left: 10px;z-index: 10000;" width="160" src="<%=path%>/images/bycycle.png">
<ul style="width:200px;height:100px;list-style: none;position: absolute;top:5px;margin-left: 940px;z-index: 10000;">
    <li><img width="50" id="music" onclick="playMusic(this)" src="<%=path%>/images/musicBtn.png"></li>
    <li class="last"><p id="time">00:00:00</p></li>
</ul>
<audio src="<%=path%>/video/LegendsNeverDie.mp3" autoplay="autoplay" loop="loop" id="player"></audio>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><img width="50" src="<%=path%>/images/ludalogo.png">赛事中心</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a id="corp">组建团队</a></li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="<%=path%>/image/${nowUser.userimage}" class="layui-nav-img">
                    ${nowUser.username}
                </a>
                <dl class="layui-nav-child">
                    <dd><a id="myinfo">我的主页</a></dd>
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
                <li class="layui-nav-item"><a id="lookmatch">赛事预览</a></li>
                <li class="layui-nav-item"><a id="looknotice">通告</a></li>
                <li class="layui-nav-item"><a id="applyjudge">申请裁判</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe id="iframe" src="<%=path%>/frames/over.jsp?param=6" name="frame" width="100%" height="100%">
        </iframe>



    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 鲁东大学软件工程系 - 率为朋
    </div>
</div>



<script src="<%=path%>/layui/layui.js"></script>
<script>
    function playMusic(obj){
        var player=document.getElementById("player");
        if(player.paused){
            //播放音乐
            player.play();
            obj.src="<%=path%>/images/musicBtn.png";
        }else{
            //暂停音乐
            player.pause();
            obj.src="<%=path%>/images/musicBtnOff.png";
        }
    }



    layui.use('layer', function(){
        var element = layui.element;
        var $=layui.jquery;
        $("#index").click(function () {
            //跳转首页,需要过渡页
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=6");
        })
        $("#lookmatch").click(function () {
            //浏览赛事
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=7");
        })
        $("#corp").click(function () {
            //组建团队
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=8");
        })
        $("#myinfo").click(function () {
            //我的主页
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=9");
        })
        $("#looknotice").click(function () {
            //查看通告
            $("#iframe").attr("src","<%=path%>/frames/over.jsp?param=10");
        })
        $("#applyjudge").click(function () {
            layer.prompt({
                formType: 2,
                title: '请输入您擅长的比赛类型',
                area: ['210px', '50px'] //自定义文本域宽高
            }, function(value, index, elem){
               $.ajax({
                   type:'get',
                   url:"<%=path%>/judge/addjudge.do",
                   data:{judgetype:value},
                   success:function (response) {
                       layer.alert(response.msg)
                   }
               })
                layer.close(index);
            });
        })


        $(document).ready(function(e){
            //定时器，每隔一秒钟，获取一次数据
            //参数一： 自定义的方法 参数二：间隔时间
            setInterval(function(){
                var datas=new Date();
                //获取时分秒
                var h=datas.getHours();
                var m=datas.getMinutes();
                var s=datas.getSeconds();
                if(h<10){
                    h="0"+h;
                }
                if(m<10){
                    m="0"+m;
                }
                if(s<10){
                    s="0"+s;
                }
                //刷新页面
                document.getElementById("time").innerHTML=h+":"+m+":"+s;
            },1000);
        });
    });
    layui.use('element', function(){
        var element = layui.element;
        var $=layui.jquery;
        <%--$("#mysign").click(function () {--%>
            <%--$.ajax({--%>
                <%--type:'get',--%>
                <%--url:'<%=path%>/enters/mysign.do',--%>
                <%--success:function (response) {--%>
                    <%--if (response.status==1){--%>
                        <%--layer.msg(response.msg)--%>
                    <%--}--%>

                <%--}--%>

            <%--})--%>

            <%--layer.open({--%>
                <%--type: 1--%>
                <%--,title: '我的报名' //不显示标题栏--%>
                <%--,closeBtn: false--%>
                <%--,area: '300px;'--%>
                <%--,shade: 0.8--%>
                <%--,id: 'LAY_layuipro' //设定一个id，防止重复弹出--%>
                <%--,btn: ['取消报名', '关闭']--%>
                <%--,btnAlign: 'c'--%>
                <%--,moveType: 1 //拖拽模式，0或者1--%>
                <%--,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">你知道吗？亲！<br>layer ≠ layui<br><br>layer只是作为Layui的一个弹层模块，由于其用户基数较大，所以常常会有人以为layui是layerui<br><br>layer虽然已被 Layui 收编为内置的弹层模块，但仍然会作为一个独立组件全力维护、升级。<br><br>我们此后的征途是星辰大海 ^_^</div>'--%>
                <%--,success: function(layero){--%>
                    <%--var btn = layero.find('.layui-layer-btn');--%>
                    <%--btn.find('.layui-layer-btn0').on('click', function() {--%>


                    <%--});--%>
                <%--}--%>
            <%--});--%>
        <%--})--%>

    });


</script>
</body>
</html>