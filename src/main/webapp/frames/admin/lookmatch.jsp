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
    <title>查看赛事</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>
<table class="layui-table" lay-data="{height:460, url:'<%=path%>/match/lookmatch.do', page:true, id:'matches'}" lay-filter="demo">
    <thead>
    <tr>
        <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
        <th lay-data="{field:'matchname', width:140,fixed: true}">比赛名称</th>
        <th lay-data="{field:'matchtype', width:120}">比赛类型</th>
        <th lay-data="{field:'sponsor', width:100}">主办方</th>
        <th lay-data="{field:'instruction', minWidth:180}">赛事说明</th>
        <th lay-data="{field:'address', minWidth:180}">赛事地点</th>
        <th lay-data="{field:'judges', width:100}">裁判</th>
        <th lay-data="{field:'officialphone', width:140}">官方电话</th>
        <th lay-data="{fixed: 'right', width:160, align:'center', toolbar: '#barDemo'}">操作</th>
    </tr>
    </thead>
</table>
<div class="layui-btn-group demoTable">
<button class="layui-btn" data-type="getCheckData">全部删除</button>
</div>

<form id="matchdetail" action="<%=path%>/match/matchDetail.do" method="get">
    <input type="hidden" id="currentid" name="matchid" value="">
</form>


<script>
    layui.use(['layer','table'],function () {
        var $=layui.jquery;
        var table=layui.table;
        $("#deleteAll").click(function () {
            var checkStatus = table.checkStatus('matches')
                ,data = checkStatus.data;
            layer.alert(JSON.stringify(data));
        })

    });
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>

    <!-- 这里同样支持 laytpl 语法，如： -->
    <%--{{#  if(d.auth > 2){ }}--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="check">审核</a>--%>
    <%--{{#  } }}--%>
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
               $("#currentid").val(data.matchid)
                $("#matchdetail").submit()
            } else if(obj.event === 'del'){

                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/match/matchDelete.do",
                        data:{ids:data.matchid},
                        datatype:"json",
                        success:function (response) {
                            layer.msg(response.msg)
                            table.reload('matches')
                        }
                    })
                    layer.close(index);
                });
            }
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                layer.confirm('真的删除所选数据么', function(index){
                    var checkStatus = table.checkStatus('matches')
                        ,data = checkStatus.data;
                    var objs=data;
                    var str=""
                    for (var i=0;i<objs.length;i++){
                        str+=objs[i].matchid+","
                    }
                    str=str.substr(0,str.length-1);
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/match/matchDelete.do",
                        data:{ids:str},
                        datatype:"json",
                        success:function (response) {
                            layer.msg(response.msg)
                            table.reload('matches')
                        }
                    })
                    layer.close(index);
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
