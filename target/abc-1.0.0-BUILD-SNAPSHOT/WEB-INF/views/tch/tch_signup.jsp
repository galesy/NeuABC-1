<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
$.validator.setDefaults({
	submitHandler : function() {
		$.ajax({
			type : 'POST',
			//contentType : 'application/json',  
			url : 'user/doRegistt',
			data : {
				username : $("#username").val(),
				password : $("#password").val(),
				agree : $("#agree").is(':checked')?"Y":"N"
			},
			dataType : 'json',
			success : function(data) {
				if (data.status == 'Success') {
					location.href = "landing";
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
$.validator.addMethod("regex", function(value, element, params) {
	var exp = new RegExp(params);
	return exp.test(value);
}, "Password need to contain 6-14 numbers or characters.");

$.validator.addMethod('agreed', function(value, element, params) { 
	return $("#agree").is(':checked');
},"You must accept the agreement to continue"); 


$().ready(function() {
	$("#username").keydown(function(){
		$("#top-error").hide();
		$("#sys-error").hide();
	});
	$("#password").keydown(function(){
		$("#top-error").hide();
		$("#sys-error").hide();
	});
	$("#agree").click(function(){
		$("#top-error").hide();
		$("#sys-error").hide();
	});
	// validate signup form on keyup and submit
	$("#loginForm").validate({
		//debug:true,
		rules : {
			username : {
				required : true,
				minlength : 6,
				maxlength : 32,
				remote : {
					url : "user/check",
					type : "post",
					dataType : "json",
					data : {
						username : function() {
				            return $("#username").val();
				        }
					}
				}
			},
			password : {
				regex : "^([a-zA-Z0-9@#$%^&_+\.]{6,14})+$",//number, digit and special char
				required : true
			},
			agree : {
				agreed : true
			},
		},
		messages : {
			username : {
				required : "Password need to contain 6-14 numbers or characters.",
				minlength : "Length of username at least 6",
				maxlength : "Length of username cannot exceed 32",
				remote : "User already has registered"
			},
			password : {
				regex : "Password requires 6-14 numbers or characters",
				required : "Password requires 6-14 numbers or characters"
			},
			agree : {
				required : "You must accept the agreement to continue"
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
            <p class="title_text">Member Register</p>
            <p class="con_text">Join the NeuABC English Teaching Community!</p>
        </div>
        <div class="signin_main_content">
            <div class="sign_link">
                <span>Already have an account? </span>
                <a href="signin.html">Login here.</a>
            </div>
            <form class="pure-form pure-form-aligned">
                <div class="pure-control-group">
                    <label for="name">Username</label>
                    <input id="aligned-name" class="username" type="text" placeholder="Username">
                    <span class="pure-form-message-inline"></span>
                </div>
                <div class="pure-control-group">
                    <label for="password">Password</label>
                    <input id="password" type="password" placeholder="Password">
                    <span class="pure-form-message-inline"></span>
                </div>
                <div class="pure-control-group">
                    <label for="email">Email</label>
                    <input id="email" type="email" placeholder="Email Address">
                    <span class="pure-form-message-inline"></span>
                </div>
                <div class="pure-controls">
                    <label for="cb" class="pure-checkbox">
                        <input id="cb" type="checkbox"> You agree that you have read our 
                        <a href="#">Privacy policy.</a>
                    </label>
                    <a href="#" class="big-link" data-reveal-id="myModal">
                    <button type="submit" class="pure-button pure-button-primary sign_button" >Register</button>
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright © 2017 JSU Technology. All rights reserved. </p>
</div>
