require(["jquery", "bsAlert", "csrfToken", "validator"], function ($, bsAlert, csrfTokenHeader) {
	
	$('form').validator().on('submit', function (e) {
        if (!e.isDefaultPrevented()) {
            //var username = $("#username").val();
            //var password = $("#password").val();
        	
        	//var params = $("input").serialize();
        	
        	var username = $("#username").val();
            var password = $("#password").val();
            var captcha = $("#captcha").val();

            $.ajax({
                beforeSend: csrfTokenHeader,
                url: "jsonLogin",
                data: {username: username, password: password, captcha: captcha},
                dataType: "json",
                method: "post",
                success: function (data) {
                    if (!data.code) {
                        function getLocationVal(id){
                            var temp = unescape(location.search).split(id+"=")[1] || "";
                            return temp.indexOf("&")>=0 ? temp.split("&")[0] : temp;
                        }
                        var from = getLocationVal("__from");
                        if(from != ""){
                            console.log(from);
                            window.location.href = from;
                        }
                        else{
                            location.href = "/Logistics_Manage_System";
                        }
                    }
                    else {
                        refresh_captcha();
                        bsAlert(data.data);
                    }
                },
                error: function(){
                    bsAlert("棰�濂藉儚鍑洪敊浜嗭紝璇峰埛鏂伴〉闈㈤噸璇曘�濡傝繕鏈夐棶棰橈紝璇峰～鍐欓〉闈㈠鑸爮涓婄殑鍙嶉銆�")
                }

            });
            return false;
        }
    });
	
	function refresh_captcha(){
        $("#captcha-img")[0].src = "<%=path%>/verifyCode/produce.do?" + Math.random();
        $("#captcha")[0].value = "";
    }
	
    $("#captcha-img").click(function(){
        refresh_captcha();
    });
    
});