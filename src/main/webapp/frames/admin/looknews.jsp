<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/29
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>查看新闻</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>
<div class="demoTable">
    搜索赛事新闻：
    <div class="layui-inline">
        <input class="layui-input" name="keyword" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<table class="layui-table" lay-data="{height:460, url:'<%=path%>/craw/lookCraw.do', page:true, id:'craw'}" lay-filter="demo">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'crawTitle', width:140,fixed: true}">新闻标题</th>
        <th lay-data="{field:'crawTime', width:120}">时间</th>
        <th lay-data="{field:'crawImage', width:100,templet:'#image'}">主题图片</th>
        <th lay-data="{field:'crawDesc', minWidth:180}">新闻描述</th>
        <th lay-data="{fixed: 'right', width:80, align:'center', toolbar: '#barDemo'}">操作</th>
    </tr>
    </thead>
</table>
<div class="layui-btn-group demoTable">
    <button class="layui-btn" data-type="getCheckData">全部删除</button>
</div>


<script>
    layui.use(['layer','table'],function () {
        var $=layui.jquery;
        var table=layui.table;
        $("#deleteAll").click(function () {
            var checkStatus = table.checkStatus('craw')
                ,data = checkStatus.data;
            layer.alert(JSON.stringify(data));
        })

    });
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <!-- 这里同样支持 laytpl 语法，如： -->
    <%--{{#  if(d.auth > 2){ }}--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="check">审核</a>--%>
    <%--{{#  } }}--%>
</script>
<script type="text/html" id="image">
    <img width="50" src="{{d.crawImage}}">
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
          if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/craw/crawDelete.do",
                        data:{ids:data.crawId},
                        datatype:"json",
                        success:function (response) {
                            layer.msg(response.msg)
                            table.reload('craw')
                        }
                    })
                    layer.close(index);
                });
            }
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                layer.confirm('真的删除所选数据么', function(index){
                    var checkStatus = table.checkStatus('craw')
                        ,data = checkStatus.data;
                    var objs=data;
                    var str=""
                    for (var i=0;i<objs.length;i++){
                        str+=objs[i].crawId+","
                    }
                    str=str.substr(0,str.length-1);
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/craw/crawDelete.do",
                        data:{ids:str},
                        datatype:"json",
                        success:function (response) {
                            layer.msg(response.msg)
                            table.reload('craw')
                        }
                    })
                    layer.close(index);
                });
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

</body>
</html>
