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
						$.cookie("rmbTch", "true", { expires: 30 });
						$.cookie("tchname", $("#username").val(), { expires: 30 }); 
						$.cookie("tchpassword", $("#password").val(), { expires: 30 }); 
					}else{
						$.cookie("rmbTch", "false", { expires: 30 });
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
	if ($.cookie("rmbTch") == "true") { 
		$("#rmb").prop("checked", true); 
		$("#username").val($.cookie("tchname")); 
		$("#password").val($.cookie("tchpassword")); 
	} 
	// validate signup form on keyup and submit
	$("#loginForm").validate({
		//debug:true,
		rules : {
			username : {
				required : true
			},
			password : {
				required : true
			}
		},
		messages : {
			username : {
				required : "Please input your username"
			},
			password : {
				required : "Please input your password"
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
            <p class="title_text">Member Login</p>
            <p class="con_text">Join the NeuABC English Teaching Community!</p>
        </div>
        <div class="signin_main_content">
            <div class="sign_link">
                <span>No account yet? </span>
                <a href="<%=request.getContextPath()%>/tch">Register here.</a>
            </div>
            <form class="pure-form pure-form-aligned" id="loginForm" name="loginForm">
                <div class="pure-control-group">
                    <label for="username">Username</label>
                    <input id="username" name="username" class="username" type="text" placeholder="Username">                    
						<span id="top-error" class="pure-form-message-inline" style="display:none">Your username and password is not correct</span>
                    	<span id="sys-error" class="pure-form-message-inline" style="display:none">System error, please contact system Admin</span>
                    <span class="pure-form-message-inline"></span>
                </div>
                <div class="pure-control-group">
                    <label for="password">Password</label>
                    <input id="password" name="password" type="password" placeholder="Password">
                    <span class="pure-form-message-inline"></span>
                </div>
                <div class="pure-controls">
                    <label for="rmb" class="pure-checkbox">
                        <input id="rmb" type="checkbox"> Remember password
                    </label>
                    <button type="submit" class="pure-button pure-button-primary sign_button">Log In</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copyu; 2017 JSU Technology. All rights reserved. </p>
</div>
<div id="myModal" class="reveal-modal">
    <p>Registration has been successfully completed.</p>
    <a href="calendar.html" class="pure-u-1-2">Go Study</a>
</div>
