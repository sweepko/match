<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/1/29
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>发布赛事</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>发布赛事</legend>
</fieldset>
<form id="matchform" class="layui-form" action="<%=path%>/match/addMatch.do" method="post" enctype="multipart/form-data">
    <div class="layui-form-item">
        <label class="layui-form-label">赛事名称</label>
        <div class="layui-input-block">
            <input type="text" name="matchname" autocomplete="off" placeholder="请输入赛事名称" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">举办方</label>
            <div class="layui-input-inline">
                <input type="text" name="sponsor" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">赛事类型</label>
            <div class="layui-input-inline">
                <input type="text" name="matchtype" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开始日期</label>
            <div class="layui-input-inline">
                <input type="text" name="startdate" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">结束日期</label>
            <div class="layui-input-block">
                <input type="text" name="enddate" id="date1" autocomplete="off" placeholder="yyyy-MM-dd" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">官方电话</label>
            <div class="layui-input-inline">
                <input type="tel" name="officialphone" lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">赛事地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" autocomplete="off" placeholder="请输入赛事地址" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选择裁判</label>
            <div  class="layui-input-inline"><select name="judges" id="alljudges">
                <option value="">选择裁判</option>
                <c:forEach items="${judges}" varStatus="i" var="item">
                    <option value="${item.judgename}">${item.judgename}---${item.judgetype}</option>
                </c:forEach>


            </select>

            </div>
        </div>
            <label class="layui-form-label">预参赛人数</label>
            <div class="layui-input-inline">
                <input type="number" name="maxenters" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">赛事详情</label>
        <div class="layui-input-block">
            <textarea id="demo" style="display: none;" ></textarea>
        </div>
    </div>

    <div class="layui-form-item layui-form-text" style="width: 600px;">
        <label class="layui-form-label">说明</label>
        <div class="layui-input-block">
            <textarea placeholder="可选择输入" name="instruction" class="layui-textarea"></textarea>
        </div>
    </div>

    <input type="file" name="image" style="margin-left: 110px;"><br><br>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <a class="layui-btn" id="matchsubmit">立即提交</a>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>






<script>
    layui.use(['form','layer', 'layedit', 'laydate','upload'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,upload=layui.upload;
        var layedit = layui.layedit;
        var $=layui.jquery;
        var index;
        $("#matchsubmit").click(function () {
            var formdata=new FormData($("#matchform")[0])
            formdata.append("matchdetails",layedit.getContent(index))
            $.ajax({
                type:'post',
                url:"<%=path%>/match/addMatch.do",
                processData: false,
                contentType: false,
                data:formdata,
                success:function (response) {
                    layer.msg(response.msg,{icon: 6,offset:'t'})
                }
            })
        });
        layedit.set({
            uploadImage: {
                url: '<%=path%>/match/uploadImg.do' //接口url
                ,type: 'post' //默认post
            }
        });
        index=layedit.build('demo'); //建立编辑器
        //日期
        laydate.render({
            elem: '#date'
        });
        laydate.render({
            elem: '#date1'
        });

        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,content: function(value){
                layedit.sync(editIndex);
            }
        });

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
        //拖拽上传
        upload.render({
            elem: '#test10'
            ,url: '/upload/'
            ,done: function(res){
                console.log(res)
            }
        });
    });
</script>
</body>
</html>
