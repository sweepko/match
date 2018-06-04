<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/2/7
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>赛事详情</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css" media="all">
    <script src="<%=path%>/layui/layui.js" charset="utf-8"></script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>赛事详情</legend>
</fieldset>
<form id="matchform" action="<%=path%>/match/updateMatch.do" method="post" class="layui-form"  enctype="multipart/form-data">
   <input type="hidden" name="matchid" value="${match.matchid}">
    <div class="layui-form-item">
        <label class="layui-form-label">赛事名称</label>
        <div class="layui-input-block">
            <input type="text" name="matchname" value="${match.matchname}" autocomplete="off" placeholder="请输入赛事名称" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">举办方</label>
            <div class="layui-input-inline">
                <input type="text" name="sponsor" value="${match.sponsor}" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">赛事类型</label>
            <div class="layui-input-inline">
                <input type="text" name="matchtype" value="${match.matchtype}" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开始日期</label>
            <div class="layui-input-inline">
                <input type="text" name="startdate" value="${match.startdate}" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">结束日期</label>
            <div class="layui-input-block">
                <input type="text" name="enddate" id="date1" value="${match.enddate}" autocomplete="off" placeholder="yyyy-MM-dd" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">官方电话</label>
            <div class="layui-input-inline">
                <input type="tel" name="officialphone" value="${match.officialphone}" lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">参赛选手</label>
            <div class="layui-input-block">
                <input type="text" name="enters" id="enters" style="width: 760px;" value="${match.enters}" autocomplete="off" placeholder="参赛选手" class="layui-input">
            </div>
        </div>
            <div class="layui-inline">
                <select lay-filter="test"  lay-verify="required" lay-search="" id="selectenter">
                    <option value="">总选手名单</option>
                    <c:forEach varStatus="i" items="${enters}" var="item">
                    <option value="${item.realname}">${item.realname}</option>
                    </c:forEach>
                </select>
            </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">赛事地址</label>
            <div class="layui-input-block">
                <input type="text" name="address" value="${match.address}" autocomplete="off" placeholder="请输入赛事地址" class="layui-input">
            </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选择裁判</label>
            <div  class="layui-input-inline">
                <select name="judges"  id="alljudges">
                <option value="${match.judges}">${match.judges}</option>
                <c:forEach items="${judges}" varStatus="i" var="item">
                    <option value="${item.judgename}">${item.judgename}---${item.judgetype}</option>
                </c:forEach>
            </select>
            </div>
        </div>
        <label class="layui-form-label">预参赛人数</label>
        <div class="layui-input-inline">
            <input type="number" name="maxenters" value="${match.maxenters}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div id="detail" style="display: none">${match.matchdetails}</div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">赛事详情</label>
        <div class="layui-input-block">
            <textarea id="detaildemo" style="display: none;"></textarea>
        </div>
    </div>
    <input type="hidden" id="instruction1" value="${match.instruction}">
    <div class="layui-form-item layui-form-text" style="width: 600px;">
        <label class="layui-form-label">说明</label>
        <div class="layui-input-block">
            <textarea placeholder="可选择输入" id="instruction" name="instruction" class="layui-textarea"></textarea>
        </div>
    </div>

    <input type="file" name="image" style="margin-left: 110px;"><br><br>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <a class="layui-btn" id="matchsubmit">确认修改</a>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>




<script>
    layui.use(['form', 'layedit', 'laydate','upload'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,upload=layui.upload;
        var layedit = layui.layedit;
        var $=layui.$;
        var index;
        layedit.set({
            uploadImage: {
                url: '<%=path%>/match/uploadImg.do' //接口url
                ,type: 'post' //默认post
            }
        });

        $("#matchsubmit").click(function () {
            var formdata=new FormData($("#matchform")[0]);
            formdata.append("matchdetails",layedit.getContent(index))
            $.ajax({
                type:'post',
                url:"<%=path%>/match/updateMatch.do",
                processData: false,
                contentType: false,
                data:formdata,
                success:function (response) {
                    layer.msg(response.msg,{icon: 6,offset:'t'})
                }
            })

        })

        var detail=$("#detail").html();
        $("#detaildemo").text(detail)
        $("#instruction").val($("#instruction1").val())
        index=layedit.build('detaildemo'); //建立编辑器
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
        form.on('select(test)', function(data){
            var enters=$("#enters").val()
            enters+=data.value+";"
            $("#enters").val(enters)
        });

    });
</script>
</body>
</html>
