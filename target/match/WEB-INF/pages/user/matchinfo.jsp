<%--
  Created by IntelliJ IDEA.
  User: MaDiudiu
  Date: 2018/2/27
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>赛事信息</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>赛事详情</legend>
</fieldset>
    <input type="hidden" id="matchid" name="matchid" value="${match.matchid}">
    <div class="layui-form-item">
        <label class="layui-form-label">赛事名称</label>
        <div class="layui-input-block">
            <input type="text" disabled name="matchname" value="${match.matchname}" autocomplete="off" placeholder="请输入赛事名称" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">举办方</label>
            <div class="layui-input-inline">
                <input type="text" disabled name="sponsor"  value="${match.sponsor}" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">赛事类型</label>
            <div class="layui-input-inline">
                <input type="text" disabled name="matchtype" value="${match.matchtype}" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开始日期</label>
            <div class="layui-input-inline">
                <input type="text" disabled name="startdate" value="${match.startdate}" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">结束日期</label>
            <div class="layui-input-block">
                <input type="text" disabled name="enddate" id="date1" value="${match.enddate}" autocomplete="off" placeholder="yyyy-MM-dd" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">官方电话</label>
            <div class="layui-input-inline">
                <input type="tel" disabled name="officialphone" value="${match.officialphone}" lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">参赛选手</label>
            <div class="layui-input-block">
                <input type="text" disabled name="enters" id="enters" style="width: 760px;" value="${match.enters}" autocomplete="off" placeholder="参赛选手" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">赛事地址</label>
        <div class="layui-input-block">
            <input type="text" disabled name="address" value="${match.address}" autocomplete="off" placeholder="请输入赛事地址" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">裁判</label>
            <div class="layui-input-inline">
                <input type="text" disabled name="judges" value="${match.judges}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <label class="layui-form-label">预参赛人数</label>
        <div class="layui-input-inline">
            <input type="text" disabled name="maxenters" value="${match.maxenters}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div id="detail" style="display: none">${match.matchdetails}</div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">赛事详情：</label>
        <br>
        <div class="layui-input-block">
            <div style="min-height: 60px;min-width: 1000px;" id="matchdetail" name="matchdetail"></div>
        </div>
    </div>
    <input type="hidden" id="instruction1" value="${match.instruction}">
    <div class="layui-form-item layui-form-text" style="width: 600px;">
        <label class="layui-form-label">说明：</label>
        <div class="layui-input-block">
            <br>
            <div id="instruction" name="instruction"></div>
        </div>
    </div>
        <div class="layui-input-block">
            <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
            <button data-method="confirmTrans" class="layui-btn">立即报名</button>
                <button data-method="cancleSign" class="layui-btn">取消报名</button>
            </div>
        </div>



<script src="<%=path%>/layui/layui.js"></script>
<script>
    layui.use(['form','layer'], function(){
        var form = layui.form
            ,layer = layui.layer
        var $=layui.$;
        var detail=$("#detail").html();
        $("#matchdetail").html(detail)
        $("#instruction").html($("#instruction1").val())
        function signcorps() {

        }
        //触发事件
        var active = {
            confirmTrans: function(){
                //配置一个透明的询问框
                layer.confirm('请选择个人报名或者团队报名', {
                    time: 20000, //20s后自动关闭
                    offset:'t',
                    btn: ['个人报名', '团队报名', '取消']
                    },function(index){
                        //个人报名
                        $.ajax({
                            type:'post',
                            url:'<%=path%>/enters/addEnter.do',
                            data:{matchid:$("#matchid").val()},
                            success:function (response) {
                                layer.msg(response.msg)
                            }
                        });
                        layer.close(index)
                    },function (index) {
                        //团队报名
                    $.ajax({
                        type:"post",
                        url:'<%=path%>/corps/getMyCorps.do',
                        success:function (response) {
                            if (response.data.length==0){
                                layer.msg("对不起，您暂无战队！")
                                return;
                            }
                        var str='<div align="center">'
                        var objs=response.data
                            for(var i=0;i<objs.length;i++){
                                str+='<input type="radio" name="corp" value="'+objs[i].corpsId+'"/>'+objs[i].corpsName+'<br>';
                            }
                            str+='</div>'
                            layer.open({
                                type: 1
                                ,title: '选择报名战队' //不显示标题栏
                                ,closeBtn: false
                                ,offset:'t'
                                ,area: '300px;'
                                ,shade: 0.8
                                ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                                ,btn: ['确认', '取消']
                                ,btnAlign: 'c'
                                ,moveType: 1 //拖拽模式，0或者1
                                ,content: str
                                ,success: function(layero){

                                    var btn = layero.find('.layui-layer-btn');
                                    btn.find('.layui-layer-btn0').on('click', function(){
                                        var id=$("input[name='corp']").val()
                                        var matchid=$("#matchid").val()
                                        $.ajax({
                                            type:'post',
                                            url:'<%=path%>/corps/signCorps.do',
                                            data:{corpsid:id,matchid:matchid},
                                            success:function (response) {
                                                layer.msg(response.msg)
                                            }
                                        })
                                    });
                                }
                            });
                        }
                    });
                    layer.close(index)
                    }
                );
            },
            cancleSign:function () {
                var matchid=$("#matchid").val()
                $.ajax({
                    type:'post',
                    url:'<%=path%>/enters/cancle.do',
                    data:{matchid:matchid},
                    success:function (response) {
                        layer.msg(response.msg)
                    }
                })
            }

        };





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
            enters+=data.value+"|"
            $("#enters").val(enters)
        });
        $('#layerDemo .layui-btn').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

    });
</script>
</body>
</html>

