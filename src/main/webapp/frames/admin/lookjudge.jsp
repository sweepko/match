<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/30
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>查看裁判界面</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>裁判信息</legend>
</fieldset>

<table class="layui-table" lay-data="{height: 400, url:'<%=path%>/judge/getAllJudge.do', initSort: {field:'matchnum', type:'desc'}}" lay-filter="event">
    <thead>
    <tr>
        <th lay-data="{field:'judgename',edit:'text', width:150}">裁判姓名</th>
        <th lay-data="{field:'judgeage',edit:'text', width:150}">裁判年龄</th>
        <th lay-data="{field:'judgesex',edit:'text', width:150}">裁判性别</th>
        <th lay-data="{field:'judgetype',edit:'text', width: 150}">裁判类型</th>
        <th lay-data="{field:'right', toolbar: '#barDemo', minWidth: 180}">操作栏</th>
    </tr>
    </thead>
</table>








<script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>&nbsp;&nbsp;&nbsp;
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>



    <%--{{#  if(d.auth > 2){ }}--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="check">审核</a>--%>
    <%--{{#  } }}--%>
</script>

<script>
    layui.use('table', function(){
        var table = layui.table;
        var $=layui.jquery;
        table.on('tool(event)', function(obj){
            var data = obj.data;
            var layEvent = obj.event;
            var tr = obj.tr;

          if(layEvent === 'del'){ //删除
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/judge/delJudge.do",
                        data:{judgeid:data.judgeid},
                        success:function (response) {
                            if (response.status=="0"){
                                layer.msg("删除信息成功！", {icon: 1})
                            }else{
                                layer.msg('删除信息失败！', {icon: 5});
                            }
                        }
                    });
                });
            } else if(layEvent === 'edit'){ //修改
                layer.confirm('确认要修改么', function(index){
                    layer.close(index);
                    $.ajax({
                        type:"post",
                        url:"<%=path%>/judge/updateJudge.do",
                        data:{judgeid:data.judgeid,judgename:data.judgename,judgeage:data.judgeage,judgeemail:data.judgeemail,
                            matchnum:data.matchnum,judgesex:data.judgesex,judgetype:data.judgetype,judgeimage:data.judgeimage},
                        success:function (response) {
                            if (response.status=="0"){
                                layer.msg("修改信息成功！", {icon: 1})
                            }else{
                                layer.msg('修改信息失败！', {icon: 5});
                            }
                        }
                    });
                });


                //同步更新缓存对应的值
                // obj.update({
                //     username: '123'
                //     ,title: 'xxx'
                // });
            }
        });

    });
</script>
</body>
</html>
