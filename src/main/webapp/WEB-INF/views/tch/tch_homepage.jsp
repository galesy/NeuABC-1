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
						location.href = "prodintro";
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
					agreed : "You must accept the agreement to continue"
				}
			},
			errorElement : "em",
			errorPlacement : function(error, element) {
				error.appendTo(element.parent().children().last());
			}

		});

	});
</script>

<div class="home_main_content_wrapper home_t_main_content_wrapper pure-u-1  pure-g">
	<div class="home_t_main_content_banner_title pure-u-20-24 pure-u-sm-1-2">
        <span class="plane_s"></span>
        <span class="plane"></span>
    	<span class="t_text_title pure-u-1">Part-time Teaching<br />
            Full-time Fun!</span>
    	<span class="t_text_small pure-u-1">
            Join the NeuABC<br />
            English Teaching Community!
        </span>
    </div>
    <div class="home_t_main_content_banner_selbox pure-u-20-24 pure-u-xl-1">
    	<div class="home_main_content_banner_sel pure-u-1 pure-u-xl-1-2">
            <div class="signin_main_content">
                <div class="sign_link">
                    <span>Already have an account? </span>
                    <a href="<%=request.getContextPath()%>/signin">Sign In here.</a>
                </div>
                <form class="pure-form pure-form-aligned" id="loginForm"
					name="loginForm">
                    <div class="pure-control-group">
                        <label for="username">Username</label>
                        <input class="username" id="username" name="username" type="text" placeholder="Username">                        
						<span id="top-error" class="pure-form-message-inline" style="display:none">System error, please contact system Admin</span>
                    	<span id="sys-error" class="pure-form-message-inline" style="display:none">System error, please contact system Admin</span>
                        <span class="pure-form-message-inline"></span>
                    </div>
                    <div class="pure-control-group">
                        <label for="password">Password</label>
                        <input id="password" name="password" type="password" placeholder="Password">
                        <span class="pure-form-message-inline"></span>
                    </div>
                    <div class="pure-control-group">
                        	<label for="agree" > </label>
                            <input id="agree" name="agree" type="checkbox"> You agree that you have read our 
                            <a href="#">Privacy policy.</a>
                            <span class="pure-form-message-inline" style="margin-top:-24px"></span>
                    </div>
                    <div class="pure-controls">
                        <button type="submit" class="pure-button pure-button-primary sign_button" style="margin-top:0px">Sign Up</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="home_t_aim_content_wrapper pure-u-1 pure-g">
    	<div class="pure-u-1-24 pure-u-lg-1-6 pure-u-sm-2-24"></div>
    	<div class="aim_box pure-u-22-24 pure-u-lg-1-6 pure-u-sm-6-24">
        	<div class="aim_img_orange"><span class="aim_img_1"></span></div>
        	<div class="aim_con">
                <h1>Who We <span class="orange">Are</span></h1>
                <p>Our sophisticated virtual classroom streams passionate, qualified teachers into Chinese homes, linking the world through education.</p>
            </div>
        </div>
    	<div class="pure-u-1-24 pure-u-lg-1-12 pure-u-sm-1-24"></div>
    	<div class="aim_box pure-u-22-24 pure-u-lg-1-6 pure-u-sm-6-24">
        	<div class="aim_img_blue"><span class="aim_img_2"></span></div>
        	<div class="aim_con">
                <h1>What We <span class="orange">Believe</span></h1>
                <p>We believe that there is a better, more effective way to teach a foreign language.</p>
            </div>
        </div>
    	<div class=" pure-u-1-24 pure-u-lg-1-12 pure-u-sm-1-24"></div>
    	<div class="aim_box pure-u-22-24 pure-u-lg-1-6 pure-u-sm-6-24">
        	<div class="aim_img_orange"><span class="aim_img_3"></span></div>
        	<div class="aim_con">
                <h1>What We <span class="orange">Do</span></h1>
                <p>We provide 1-on-1 online full immersion language and content classes based on the US Common Core State Standards.</p>
            </div>
        </div>
    	<div class="pure-u-1-24 pure-u-lg-1-6 pure-u-sm-2-24"></div>
</div>
<div class="home_t_teacher_content_wrapper pure-u-1 pure-g">
	<div class="pure-u-1-24 pure-u-md-1-6 pure-u-sm-2-24"></div>
	<div class="pure-u-22-24 pure-u-md-2-3 pure-u-sm-20-24">
    	<h1 class="pure-u-1">Teacher Testimonials</h1>
    	<div class="teacher_dialogs pure-u-1">
        	<div class="teacher_left pure-u-1-8">
            	<img class="img pure-img" src="<%=request.getContextPath()%>/static/neu/images/girl-1252997_960_720.jpg" />
                <p>Sophia</p>
            </div>
            <div class="pure-u-7-8">
                <div class="teacher_right">
                    <span class="teacher_right_arrow"></span>
                    <p class="dialogs_text">
                    NeuABC is an amazing opportunity for teachers who, like myself, had to take a hiatus for whatever reason, or even for those teachers that want a little extra income on the side.
                    </p>
                </div>
            </div>
    	</div>
    	<div class="teacher_dialogs pure-u-1">
            <div class="pure-u-7-8">
                <div class="teacher_right">
                    <p class="dialogs_text">
                    NeuABC is an amazing opportunity for teachers who, like myself, had to take a hiatus for whatever reason, or even for those teachers that want a little extra income on the side.
                    </p>
                    <span class="teacher_right_left_arrow"></span>
                </div>
            </div>
        	<div class="teacher_left teacher_right_left pure-u-1-8">
            	<img class="img pure-img" src="<%=request.getContextPath()%>/static/neu/images/girl-1252997_960_720.jpg" />
                <p>Sophia</p>
            </div>
    	</div>
    	<div class="teacher_dialogs pure-u-1">
        	<div class="teacher_left pure-u-1-8">
            	<img class="img pure-img" src="<%=request.getContextPath()%>/static/neu/images/girl-1252997_960_720.jpg" />
                <p>Sophia</p>
            </div>
            <div class="pure-u-7-8">
                <div class="teacher_right">
                    <span class="teacher_right_arrow"></span>
                    <p class="dialogs_text">
                    NeuABC is an amazing opportunity for teachers who, like myself, had to take a hiatus for whatever reason, or even for those teachers that want a little extra income on the side.
                    </p>
                </div>
            </div>
    	</div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>
</body>
</html>
