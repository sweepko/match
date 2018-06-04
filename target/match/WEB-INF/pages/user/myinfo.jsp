<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/3/6
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>我的主页</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">

</head>
<body>
<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this">我的主页</li>
        <li>我的比赛</li>
    </ul>
    <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <br>
                <br>
                <form id="myinfo" action="" method="post">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">用户名</label>
                        <div class="layui-input-inline">
                            <input type="text" name="username" value="${nowUser.username}" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-inline">
                            <input type="text" name="email" value="${nowUser.email}"  autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">性别</label>
                        <div class="layui-input-inline">
                            <input type="text" name="sex" value="${nowUser.sex}" disabled autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">年龄</label>
                        <div class="layui-input-inline">
                            <input type="text" name="age" value="${nowUser.age}" disabled autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-tab-item layui-show">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">电话</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" value="${nowUser.phone}" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">真实姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="realname" value="${nowUser.realname}" disabled autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">创建时间</label>
                    <div class="layui-input-inline">
                        <input style="width: 300px;" type="text"  name="createTime" value="${nowUser.createTime}" disabled autocomplete="off" class="layui-input">
                    </div>
                </div>
                    <br><br>
                    <input type="hidden" id="motto1" value="${nowUser.motto}">
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">个性签名</label>
                        <div class="layui-input-block">
                            <textarea placeholder="请输入个性签名" name="motto" id="motto2" class="layui-textarea"></textarea>
                        </div>
                    </div>
                    <br>
                    <a id="updateSubmit" style="margin-left: 100px;" class="layui-btn">立即修改</a>
                </form>
                <div style="position: absolute;right: 200px;top: 70px;">
                    <div class="layui-upload">
                        <button type="button" class="layui-btn" id="test1">上传图片</button>
                        <div class="layui-upload-list">
                            <div style="width: 200px;height: 200px;overflow: hidden;">
                            <img class="layui-upload-img" width="210" name="file" src="<%=path%>/image/${nowUser.userimage}" id="demo1">
                            </div>
                            <p id="demoText"></p>
                        </div>
                    </div>
                </div>
            </div>

        <div class="layui-tab-item">
            <ul class="layui-timeline">
                <c:forEach items="${mymatch}" varStatus="i" var="item">

                    <li style="position: relative" class="layui-timeline-item">
                        <div style="width: 200px;height: 160px;overflow: hidden;position: absolute;right: 200px;margin-top: 10px;">
                            <img src="<%=path%>/image/${item.match.matchimage}" width="200">
                        </div>
                    <i class="layui-icon layui-timeline-axis"></i>
                    <div class="layui-timeline-content layui-text">
                        <h3 class="layui-timeline-title">${item.match.startdate}</h3>
                        <p>
                            比赛：${item.match.matchname};主办方:${item.match.sponsor}
                            <br>成绩：${item.enters.score}
                            <br>${item.enters.describes}<i class="layui-icon"></i>
                        </p>
                    </div>
                </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>




<script src="<%=path%>/layui/layui.js"></script>
<script>
    layui.use('layer', function() {
        var element = layui.element;
        var $ = layui.jquery;
        $("#motto2").text($("#motto1").val())
        $("#updateSubmit").click(function () {
            $.ajax({
                type:'post',
                url:'<%=path%>/user/updateUser.do',
                datatype:'json',
                data:$("#myinfo").serialize(),
                success:function (response) {
                    layer.msg(response.msg)
                }
            })
        })

    });
</script>
<script>
    layui.use('element', function(){
        var $ = layui.jquery
            ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

        //触发事件
        var active = {
            tabAdd: function(){
                //新增一个Tab项
                element.tabAdd('demo', {
                    title: '新选项'+ (Math.random()*1000|0) //用于演示
                    ,content: '内容'+ (Math.random()*1000|0)
                    ,id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
                })
            }
            ,tabDelete: function(othis){
                //删除指定Tab项
                element.tabDelete('demo', '44'); //删除：“商品管理”


                othis.addClass('layui-btn-disabled');
            }
            ,tabChange: function(){
                //切换到指定Tab项
                element.tabChange('demo', '22'); //切换到：用户管理
            }
        };

        $('.site-demo-active').on('click', function(){
            var othis = $(this), type = othis.data('type');
            active[type] ? active[type].call(this, othis) : '';
        });

        //Hash地址的定位
        var layid = location.hash.replace(/^#test=/, '');
        element.tabChange('test', layid);

        element.on('tab(test)', function(elem){
            location.hash = 'test='+ $(this).attr('lay-id');
        });

    });
</script>
<script>
    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '<%=path%>/user/uploadimage.do'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                //上传成功
                return layer.msg('修改头像成功！');
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });

    });
</script>
</body>
</html>
