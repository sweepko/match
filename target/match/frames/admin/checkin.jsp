<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/3/12
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>登记选手信息</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>
<h2 align="center">选手登记</h2>
<table class="layui-table" lay-data="{height:500, url:'<%=path%>/enters/checkin.do', page:true, id:'handle'}" lay-filter="demo1">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'realname', width:200,fixed: true,templet:'#realname'}">报名者</th>
        <th lay-data="{field:'userimage', width:200,templet:'#image'}">照片</th>
        <th lay-data="{field:'phone', width:140,templet:'#phone'}">联系方式</th>
        <th lay-data="{field:'matchname', width:200,templet:'#matchname'}">比赛名称</th>
        <th lay-data="{field:'enters', minWidth:200,templet:'#enters'}">参赛者</th>
        <th lay-data="{ width:160, align:'center', toolbar: '#barDemo'}">操作</th>
    </tr>
    </thead>
</table>


<script>
    layui.use(['table','layer'], function(){
        var $ = layui.jquery, layer = layui.layer;
                //多窗口模式，层叠置顶
        var table = layui.table;
        //监听工具条
        table.on('tool(demo1)', function(obj){
            var data = obj.data;
            if(obj.event === 'check1') {
                layer.open({
                    type: 1 //此处以iframe举例
                    ,title: '登记选手比赛结果'
                    ,area: ['500px', '320px']
                    ,shade: 0
                    ,maxmin: true
                    ,offset:'t'
                    ,content: ' <br><br><div class="layui-inline">\n' +
                    '      <label class="layui-form-label">成绩录入</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <input id="score" type="tel" name="score" autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div><br><br><div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label">结果描述</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <textarea id="entersdescribe" placeholder="请输入内容" class="layui-textarea"></textarea>\n' +
                    '    </div>\n' +
                    '  </div>'
                    ,btn: ['确认提交', '取消'] //只是为了演示
                    ,yes: function(){
                        $.ajax({
                            type: "post",
                            url: "<%=path%>/enters/register.do",
                            data: {entersid: data.entersid,score:$("#score").val(),describe:$("#entersdescribe").val()},
                            datatype: "json",
                            success: function (response) {
                                if (response.status == "0") {
                                    alert("录入成功！", {icon: 1})
                                } else {
                                    alert("录入失败！", {icon: 5})
                                }
                                layer.closeAll();
                            }
                        });
                    }
                    ,btn2: function(){
                        layer.closeAll();
                    }

                    ,zIndex: layer.zIndex //重点1
                    ,success: function(layero){
                        layer.setTop(layero); //重点2
                    }
                });

            }
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据

            },
            reload: function(){
                var demoReload = $('#demoReload');
                table.reload('craw', {
                    where: {
                        keyword: demoReload.val()
                    }
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                    }
                });
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="check1">登记</a>
</script>
<script type="text/html" id="image">
    <img width="59" src="<%=path%>/image/{{d.user.userimage}}">
</script>
<script type="text/html" id="realname">
    {{d.user.realname}}
</script>
<script type="text/html" id="sex">
    {{d.user.sex}}
</script>
<script type="text/html" id="age">
    {{d.user.age}}
</script>
<script type="text/html" id="phone">
    {{d.user.phone}}
</script>
<script type="text/html" id="matchname">
    {{d.match.matchname}}
</script>
<script type="text/html" id="matchtype">
    {{d.match.matchtype}}
</script>
<script type="text/html" id="enters">
    {{#  if(d.match.enters == null){ }}
    暂无
    {{#  } else { }}
    {{d.match.enters}}
    {{#  } }}
</script>

<h2 align="center">战队登记</h2>
<%--战队报名信息--%>
<table class="layui-table" lay-data="{height:500, url:'<%=path%>/corps/checkin.do', page:true, id:'corpshandle'}" lay-filter="demo2">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'realname', width:150,fixed: true,templet:'#corpsname'}">战队名称</th>
        <th lay-data="{field:'userimage', width:200,templet:'#corpspersons'}">战队成员</th>
        <th lay-data="{field:'phone', minWidth:140,templet:'#introduce'}">战队介绍</th>
        <th lay-data="{field:'phone', width:140,templet:'#cimage'}">战队头像</th>
        <th lay-data="{field:'matchname', width:150,templet:'#cmatchname'}">比赛名称</th>
        <th lay-data="{field:'enters', minWidth:150,templet:'#centers'}">参赛者</th>
        <th lay-data="{ width:160, align:'center', toolbar: '#cbarDemo'}">操作</th>
    </tr>
    </thead>
</table>


<script>
    layui.use(['table','layer'], function(){
        var $ = layui.jquery, layer = layui.layer;
        var table = layui.table;
        //监听工具条
        table.on('tool(demo2)', function(obj){
            var data = obj.data;
            if(obj.event === 'check2') {
                layer.open({
                    type: 1 //此处以iframe举例
                    ,title: '登记选手比赛结果'
                    ,area: ['500px', '320px']
                    ,shade: 0
                    ,maxmin: true
                    ,offset:'t'
                    ,content: ' <br><br><div class="layui-inline">\n' +
                    '      <label class="layui-form-label">成绩录入</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <input id="score2" type="tel" name="score" autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div><br><br><div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label">结果描述</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <textarea id="entersdescribe2" placeholder="请输入内容" class="layui-textarea"></textarea>\n' +
                    '    </div>\n' +
                    '  </div>'
                    ,btn: ['确认提交', '取消'] //只是为了演示
                    ,yes: function(){
                        $.ajax({
                            type: "post",
                            url: "<%=path%>/corps/register.do",
                            data: {corpsid: data.corps.corpsId,score:$("#score2").val(),describe:$("#entersdescribe2").val()},
                            datatype: "json",
                            success: function (response) {
                                if (response.status == "0") {
                                    alert("录入成功！", {icon: 1})
                                } else {
                                    alert("录入失败！", {icon: 5})
                                }
                                layer.closeAll();
                            }
                        });
                    }
                    ,btn2: function(){
                        layer.closeAll();
                    }

                    ,zIndex: layer.zIndex //重点1
                    ,success: function(layero){
                        layer.setTop(layero); //重点2
                    }
                });
            }
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据

            },
            reload: function(){
                var demoReload = $('#demoReload');
                table.reload('craw', {
                    where: {
                        keyword: demoReload.val()
                    }
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                    }
                });
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>
<script type="text/html" id="cbarDemo">
    <a class="layui-btn layui-btn-xs" lay-event="check2">登记</a>
</script>
<script type="text/html" id="corpsname">
    {{d.corps.corpsName}}
</script>
<script type="text/html" id="corpspersons">
    {{d.corps.corpsPersons}}
</script>
<script type="text/html" id="introduce">
    {{d.corps.corpsIntroduce}}
</script>
<script type="text/html" id="cmatchname">
    {{d.match.matchname}}
</script>
<script type="text/html" id="cmatchtype">
    {{d.match.matchtype}}
</script>
<script type="text/html" id="cimage">
    <img width="60" src="<%=path%>/image/{{d.corps.corpsImage}}">
</script>
<script type="text/html" id="centers">
    {{#  if(d.match.enters == null){ }}
    暂无
    {{#  } else { }}
    {{d.match.enters}}
    {{#  } }}
</script>
</body>
</html>
