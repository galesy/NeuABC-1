<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$.validator.setDefaults({
		submitHandler : function() {
			$.ajax({
				type : 'POST',
				//contentType : 'application/json',  
				url : 'doLogin',
				data : {
					username : $("#username").val(),
					password : $("#password").val()
				},
				dataType : 'json',
				success : function(data) {
					if (data.status == 'success') {
						if($('#rmb').is(':checked')){
							$.cookie("rmbUser", "true", { expires: 30 });
							$.cookie("username", $("#username").val(), { expires: 30 }); 
							$.cookie("password", $("#password").val(), { expires: 30 }); 
						}else{
							$.cookie("rmbUser", "false", { expires: 30 });
						}				
						location.href = "/landing";
					} else {
						$("#top-error").show();
					}
				},
				error : function(data) {
					$("#sys-error").show();
				}
			});
		}
	});
	
	

	$().ready(function() {
		$("#username").keydown(function(){
			$("#top-error").hide();
			$("#sys-error").hide();
		});
		$("#password").keydown(function(){
			$("#top-error").hide();
			$("#sys-error").hide();
		});
		if ($.cookie("rmbUser") == "true") { 
			$("#rmb").prop("checked", true); 
			$("#username").val($.cookie("username")); 
			$("#password").val($.cookie("password")); 
		} 
		// validate signup form on keyup and submit
		$("#loginForm").validate({
			//debug:true,
			rules : {
				phone : {
					required : true
				},
				password : {
					required : true
				}
			},
			messages : {
				phone : {
					required : "请输入用户名"
				},
				password : {
					required : "请输入密码"
				}
			},
			errorElement : "em",
			errorPlacement : function(error, element) {
				error.appendTo(element.parent().children().last());
			}

		});

	});
</script>
<div class="signin_main_content_wrapper pure-u-1">
	<div class="signin_box_bg">
        <div class="signin_main_content_banner_title">
                <p class="title_text">会员登录</p>
                <p class="con_text">北美私人教师喊你来上课啦！立即登录预约一对一课程！</p>
        </div>
        <div class="signin_main_content">
            <div class="sign_link">
                <span>没有账户？ </span>
                <a href="stu">注册</a>
            </div>
            <form name="loginForm" id="loginForm" class="pure-form pure-form-aligned">
                <div class="pure-control-group">
                    <label for="username">手机号</label>
                    <input id="username" class="username" type="text" placeholder="请输入您注册时的Email或手机账号">
                    <span id="top-error" class="pure-form-message-inline" style="display:none">您输入的用户名或密码错误</span>
                    <span id="sys-error" class="pure-form-message-inline" style="display:none">系统出错，请联系客服人员</span>                    
                    <span class="pure-form-message-inline"></span>
                </div>
                <div class="pure-control-group">
                    <label for="password">密码</label>
                    <input id="password" name="password" type="password" placeholder="请输入您的密码">
                    <span class="pure-form-message-inline"></span>
                </div>
                <div class="pure-controls">
                    <label for="rmb" class="pure-checkbox">
                        <input id="rmb" type="checkbox">  记住密码 
                    </label>
                    <button type="submit" class="pure-button pure-button-primary sign_button">登录</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>