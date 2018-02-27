<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/2/8
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>查看通告</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>通告管理</legend>
</fieldset>
<div class="demoTable">
    搜索通告：
    <div class="layui-inline">
        <input class="layui-input" name="keyword" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<table class="layui-table" lay-data="{width:800,height:460, url:'<%=path%>/notice/lookNotice.do', page:true, id:'notice'}" lay-filter="demo">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'noticetitle', width:210,fixed: true}">通告标题</th>
        <th lay-data="{field:'noticeperson', width:180}">发布人</th>

        <th lay-data="{field:'noticedate', width:250}">发表时间</th>
        <%--<th lay-data="{field:'noticecontent', minWidth:380,templet:'#content'}">通告内容</th>--%>
        <th lay-data="{fixed: 'right', width:140, align:'center', toolbar: '#barDemo'}">操作</th>
    </tr>
    </thead>
</table>
<div class="layui-btn-group demoTable">
    <button class="layui-btn" data-type="getCheckData">全部删除</button>
</div>



<
<form action="<%=path%>/notice/selectNotice.do" method="get" id="selectNotice">
    <input type="hidden" name="noticeid" id="noticeid">
</form>>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs layui-btn-xs" lay-event="update">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <!-- 这里同样支持 laytpl 语法，如： -->
    <%--{{#  if(d.auth > 2){ }}--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="check">审核</a>--%>
    <%--{{#  } }}--%>
</script>
<script type="text/html" id="content">
    <%--<div style="height: 80px;">{{d.noticecontent}}</div>--%>
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
                        url:"<%=path%>/notice/noticeDelete.do",
                        data:{ids:data.noticeid},
                        datatype:"json",
                        success:function (response) {
                            layer.msg(response.msg)
                            table.reload('notice')
                        }
                    })
                    layer.close(index);
                });
            }else if (obj.event === 'update'){
                //修改
                $("#noticeid").val(data.noticeid)
                $("#selectNotice").submit()
            }
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                layer.confirm('真的删除所选数据么', function(index){
                    var checkStatus = table.checkStatus('notice')
                        ,data = checkStatus.data;
                    var objs=data;
                    var str=""
                    for (var i=0;i<objs.length;i++){
                        str+=objs[i].noticeid+","
                    }
                    str=str.substr(0,str.length-1);
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/notice/noticeDelete.do",
                        data:{ids:str},
                        datatype:"json",
                        success:function (response) {
                            layer.msg(response.msg)
                            table.reload('notice')
                        }
                    })
                    layer.close(index);
                });
            },
            reload: function(){
                var demoReload = $('#demoReload')
                table.reload('notice', {
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
