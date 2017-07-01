<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$.validator.setDefaults({
    submitHandler: function() {
      $.ajax( {  
        type : 'POST',  
        //contentType : 'application/json',  
        url : 'doLogin',  
        data : { 
        	username: $("#username").val(),
        	password:$("#password").val()
        },  
        dataType : 'json',  
        success : function(data) { 
        	if(data.status == 'success'){
        		location.href="tiles";
        	}else{
        		$().show();
        	}
        },  
        error : function(data) {  
        	alert(data.responseText);
        	$().show();
        }  
      });  
    }
});

$().ready(function() {

	// validate signup form on keyup and submit
	$("#loginForm").validate({
		rules: {
			username: {
				required: true
			},
			password: {
				required: true
			}
		},
		messages: {
			username: {
				required: "Please enter a username",
				minlength: "Your username must consist of at least 2 characters"
			},
			password: {
				required: "Please provide a password",
				minlength: "Your password must be at least 5 characters long"
			}
		}
	});

});
</script>
<style>
	#loginForm {
		width: 500px;
	}
	#loginForm label {
		width: 250px;
	}
	#loginForm label.error, #loginForm input.submit {
		margin-left: 253px;
	}
	#loginForm {
		width: 670px;
	}
	#loginForm label.error {
		margin-left: 10px;
		width: auto;
		display: inline;
	}
	#loginForm label.error {
		display: none;
		margin-left: 103px;
	}
	</style>

<form id="loginForm" name="loginForm">
<div class="signin_main_content_wrapper pure-u-1">
	<div class="signin_box_bg">
        <div class="signin_main_content_banner_title">
                <p class="title_text">会员登录</p>
                <p class="con_text">北美私人教师喊你来上课啦！立即登录预约一对一课程！</p>
        </div>
        <div class="signin_main_content">
            <div class="sign_link">
                <span>没有账户？ </span>
                <a href="signup-s.html">注册</a>
            </div>
            <form class="pure-form pure-form-aligned">
                <div class="pure-control-group">
                    <label for="name">手机号</label>
                    <input id="aligned-name" class="username" type="text" placeholder="请输入您注册时的Email或手机账号">
                    <span class="pure-form-message-inline">您输入的用户名不存在</span>
                </div>
                <div class="pure-control-group">
                    <label for="password">密码</label>
                    <input id="password" type="password" placeholder="请输入您的密码">
                    <span class="pure-form-message-inline">您输入的密码错误</span>
                </div>
                <div class="pure-controls">
                    <label for="cb" class="pure-checkbox">
                        <input id="cb" type="checkbox">  记住密码 
                    </label>
                    <button type="submit" class="pure-button pure-button-primary sign_button">登录</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright © 2017 NP Technology. All rights reserved. </p>
</div>
</form>