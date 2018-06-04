<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/2/8
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>发布通告</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"  media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>发布通告</legend>
</fieldset>
<form id="noticeform" class="layui-form" action="" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">通告标题</label>
        <div class="layui-input-block">
            <input type="text" name="noticetitle" autocomplete="off" placeholder="请输入通告标题" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">通告内容</label>
        <div class="layui-input-block">
            <textarea id="demo" style="display: none;"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <a class="layui-btn" lay-filter="demo1" id="noticesubmit">立即发布</a>
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
        var index;
        var $=layui.jquery;
        $("#noticesubmit").click(function () {
//            $("#noticeform").submit();
            var formdata=new FormData($("#noticeform")[0])
            formdata.append("noticecontent",layedit.getContent(index))
            $.ajax({
                type:'post',
                url:'<%=path%>/notice/addNotice.do',
                processData: false,
                contentType: false,
                data:formdata,
                success:function (response) {
                    layer.msg(response.msg)
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

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

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
