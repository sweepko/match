<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/2/28
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>组建团队</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">

</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>团队组建</legend>
</fieldset>
<br>
<form id="corpsform" lay-filter="test1" class="layui-form" action="" method="post" enctype="multipart/form-data">
    <div class="layui-form-item">
        <label class="layui-form-label">团队名称</label>
        <div class="layui-input-block">
            <input type="text" name="corpsName" autocomplete="off" placeholder="请输入团队名称" class="layui-input">
        </div>
    </div>
    <br>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">团队选手</label>
            <div class="layui-input-block">
                <input id="corpsPersons" type="hidden" name="corpsPersons">
                <input type="text" disabled  id="member" style="width: 760px;" autocomplete="off" placeholder="战队队员" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <select lay-filter="test"  lay-verify="required" lay-search="" id="selectmember">
                <option value="">名单</option>
                <c:forEach items="${users}" varStatus="i" var="item">
                    <option value="${item.email}:${item.realname}">${item.email}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <br>
    <div class="layui-form-item layui-form-text" style="width: 600px;">
        <label class="layui-form-label">团队简介</label>
        <div class="layui-input-block">
            <textarea style="width: 800px;" placeholder="简介" id="corpsIntroduce" name="corpsIntroduce" class="layui-textarea"></textarea>
        </div>
    </div>
    <br><br>

    <input type="file" name="image" style="margin-left: 110px;"><br>
    <br><br>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <a class="layui-btn" lay-filter="demo1" id="corpssubmit">确认组建</a>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>


<script src="<%=path%>/layui/layui.js"></script>
<script>
    layui.use(['form','layer'], function(){
        var form = layui.form
            ,layer = layui.layer

        var $=layui.$;
        $("#corpssubmit").click(function () {
            $("#corpsPersons").val($("#member").val())
            var corpsform=document.getElementById("corpsform");
            var data=new FormData(corpsform);
            $.ajax({
                type:"post",
                url:"<%=path%>/corps/addCorps.do",
                data:data,
                processData: false,  // 告诉jQuery不要去处理发送的数据
                contentType: false,
                success:function (response) {
                    layer.msg(response.msg)
                }
            })
        })

        //监听指定开关
        form.on('switch(switchTest)', function(data){
            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
        });

        //监听提交
        form.on('submit(demo1)', function(data){
            layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;
        });

        form.on('select(test)', function(data){
            var member=$("#selectmember").val();
            var members=$("#member").val();
            if (member!="" || member!=null){
                members+=member+";";
            }
            $("#member").val(members)
        });




    });
</script>


</body>
</html>
