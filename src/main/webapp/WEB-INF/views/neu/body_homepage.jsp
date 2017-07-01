<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$.validator.setDefaults({
		submitHandler : function() {
			$.ajax({
				type : 'POST',
				//contentType : 'application/json',  
				url : 'user/doRegists',
				data : {
					phone : $("#phone").val(),
					password : $("#password").val(),
					agree : $("#agree").val(),
					email : $("#email").val(),
					smsverify : $("#smscode").val()
				},
				dataType : 'json',
				success : function(data) {
					if (data.status == 'Success') {
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
	jQuery.validator.addMethod("regex", function(value, element, params) {
		var exp = new RegExp(params);
		return exp.test(value);
	}, "格式错误");
	$().ready(function() {
		$("#username").keydown(function(){
			$("#top-error").hide();
			$("#sys-error").hide();
		});
		$("#password").keydown(function(){
			$("#top-error").hide();
			$("#sys-error").hide();
		});
		// validate signup form on keyup and submit
		$("#loginForm").validate({
			//debug:true,
			rules : {
				phone : {
					required : true,
					minlength : 11,
					maxlength : 11,
					digits : true,
					remote : {
						url : "user/check",
						type : "post",
						dataType : "json",
						data : {
							username : $("#phone").val(),
						}
					}
				},
				password : {
					regex : "^([a-zA-Z0-9@#$%^&_+\.]{6,14})+$",//number, digit and special char
					required : true
				},
				email : {
					required : true,
					email : true
				},
			},
			messages : {
				phone : {
					required : "请输入用户名",
					minlength : "请输入11位电话号码",
					maxlength : "请输入11位电话号码",
					digits : "请输入11位电话号码",
					remote : "用户名已经被注册"
				},
				password : {
					regex : "您输入的密码不符合规范",
					required : "请输入密码"
				},
				email : {
					required : "请输入邮箱",
					email : "您输入的邮箱格式不符合规范"
				}
			},
			errorElement : "em",
			errorPlacement : function(error, element) {
				error.appendTo(element.parent().children().last());
			}

		});

	});
</script>
<div
	class="home_main_content_wrapper home_s_main_content_wrapper pure-u-1  pure-g">
	<div class="home_s_main_content_banner_title pure-u-20-24">
		<span class="student_banner_text pure-u-1">
			<h1 class="bold">NeuABC</h1>
			<p class="title">北美好外教</p>
			<p class="con_text">一对一教学&nbsp;&nbsp;随时随地教学</p>
		</span>
	</div>
	<div class="home_t_main_content_banner_selbox pure-u-20-24 pure-u-xl-1">
		<div class="home_main_content_banner_sel pure-u-1 pure-u-xl-1-2">
			<div class="signin_main_content">
				<div class="sign_link">
					<span>已有账户？ </span> <a href="<%=request.getContextPath()%>/login">登录</a>
				</div>
				<form class="pure-form pure-form-aligned" id="loginForm"
					name="loginForm">
					<div class="pure-control-group">
						<label for="phone">手机号</label> <input id="phone" name="phone"
							class="username" type="text" placeholder="请输入手机号码作为您的登录账号">
						<span id="top-error" class="pure-form-message-inline" style="display:none">注册失败，请联系客服人员</span>
                    	<span id="sys-error" class="pure-form-message-inline" style="display:none">系统出错，请联系客服人员</span>
						<span class="pure-form-message-inline"></span>
						
					</div>
					<div class="pure-control-group">
						<label for="password">密码</label> <input id="password"
							type="password" name="password"
							placeholder="请输入6～14位数字或英文的密码，不含空格"> <span id=""
							class="pure-form-message-inline"></span>
					</div>
					<div class="pure-control-group">
						<label for="email">Email</label> <input id="email" type="email"
							name="email" placeholder="请输入您的Email"> <span
							class="pure-form-message-inline"></span>
					</div>
					<div class="pure-control-group">
						<label for="smscode">手机验证码</label> <input id="smscode"
							name="smscode" type="text" placeholder="请输入手机验证码"> <a
							href="#" class="phone-code">发送验证码</a> <span
							class="pure-form-message-inline"></span>
					</div>
					<div class="pure-controls">
						<label for="cb" class="pure-checkbox"> <input id="agree"
							name="agree" type="checkbox" value="Y">我已阅读并同意 <a
							href="#">《NeuABC协议》</a>
						</label> <a href="#" class="big-link" data-reveal-id="myModal">
							<button type="submit"
								class="pure-button pure-button-primary sign_button">注册</button>
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="home_t_aim_content_wrapper pure-u-1 pure-g">
	<div class="pure-u-1-24 pure-u-lg-1-6 pure-u-sm-2-24"></div>
	<div
		class="aim_box  student_aim_box pure-u-22-24 pure-u-lg-1-6 pure-u-sm-6-24">
		<div class="aim_img_blue">
			<span class="student_aim_img_1"></span>
		</div>
		<div class="student_aim_con">
			<h1>
				<span class="">高资历</span>北美外教
			</h1>
			<p>北美外教均为北美小学教师或具备ESL教学经验，拥有良好教育背景，经过严格的面试甄选，任用懂教育、爱孩子、擅长在线授课的优秀老师。</p>
		</div>
	</div>
	<div class="pure-u-1-24 pure-u-lg-1-12 pure-u-sm-1-24"></div>
	<div
		class="aim_box student_aim_box pure-u-22-24 pure-u-lg-1-6 pure-u-sm-6-24">
		<div class="aim_img_orange">
			<span class="student_aim_img_2"></span>
		</div>
		<div class="student_aim_con">
			<h1>
				<span class="">1对1</span>定制化服务
			</h1>
			<p>北美外教1对1，打造适合中国本土小朋友的美国小学课程，因材施教。专业班主任老师一对一，全程提供五星服务，为孩子和家长及时解决各种问题，有效提升学习效果。</p>
		</div>
	</div>
	<div class=" pure-u-1-24 pure-u-lg-1-12 pure-u-sm-1-24"></div>
	<div
		class="aim_box student_aim_box pure-u-22-24 pure-u-lg-1-6 pure-u-sm-6-24">
		<div class="aim_img_green">
			<span class="student_aim_img_3"></span>
		</div>
		<div class="student_aim_con">
			<h1>
				<span class="">随时随地</span>便捷上课
			</h1>
			<p>笔记本、台式机、iPad，多终端学习平台覆盖。自由选择时间地点，随时约课、上课，免除线下机构路途奔波，高效利用碎片化学习时间。</p>
		</div>
	</div>
	<div class="pure-u-1-24 pure-u-lg-1-6 pure-u-sm-2-24"></div>
</div>
<div class="home_student_class_wrapper pure-u-1 pure-g">
	<div class="pure-u-2-24 pure-u-sm-4-24"></div>
	<div class="s_class_con pure-u-20-24 pure-u-sm-9-24">
		<h1>
			全匹配式课程设计<br />量需定制，乐享学习
		</h1>
		<p>你对语言学习的需求，将拆解成主题、程度、课程形式、外籍顾问、同学等众多面向，精准匹配，同时记录并分析每次的学习轨迹数据，为您提供直观反馈并优化下一次的学习体验。</p>
		<a href="#">了解更多上课流程&nbsp;></a>
	</div>
	<img class="s_class_bg pure-u-22-24 pure-u-sm-9-24"
		src="<%=request.getContextPath()%>/static/neu/images/student_pad.png" />


</div>
<div class="home_student_dialog_wrapper pure-u-1 pure-g">
	<div class="pure-u-1-24 pure-u-md-1-6 pure-u-sm-2-24"></div>
	<div class="pure-u-22-24 pure-u-md-2-3 pure-u-sm-20-24">
		<h1 class="pure-u-1">学员感言</h1>
		<div class="student_dialogs pure-u-1">
			<div class="student_left pure-u-1-8">
				<img class="img pure-img"
					src="<%=request.getContextPath()%>/static/neu/images/girl-1252997_960_720.jpg" />
			</div>
			<div class="pure-u-7-8">
				<div class="student_right">
					<p class="dialogs_text">"NeuABC
						是21世纪的中国教育国际化的一个深受家长欢迎和孩子喜爱的崭新而有效的实验。她通过互联网连接北美的优秀老师与中国的孩子们，为中国孩子打开了一条宽广而前途无限的通道！"
					</p>
				</div>
			</div>
		</div>
		<div class="student_dialogs pure-u-1">
			<div class="pure-u-7-8">
				<div class="student_right">
					<p class="dialogs_text">
						"NeuABC帮助更多中国孩子拥有更广阔的视野，帮助他们拥有更多机会。学习了一段时间后，发现英语听力变好了。NeuABC的母语式教学通过视听说结合，在语音与实义间建立神经反射，从根源突破，培养语感，口语提升的很快！听力提高了很多！"
					</p>
				</div>
			</div>
			<div class="student_left student_right_left pure-u-1-8">
				<img class="img pure-img"
					src="<%=request.getContextPath()%>/static/neu/images/girl-1252997_960_720.jpg" />
			</div>
		</div>
		<div class="student_dialogs pure-u-1">
			<div class="student_left pure-u-1-8">
				<img class="img pure-img"
					src="<%=request.getContextPath()%>/static/neu/images/girl-1252997_960_720.jpg" />
			</div>
			<div class="pure-u-7-8">
				<div class="student_right">
					<p class="dialogs_text">
						"传统的学习方式都以语法为基础，将英语转换成中文再对实义进行理解，刻板费力。NeuABC的母语式教学通过视听说结合，在语音与实义间建立神经反射，从根源突破，培养语感，口语提升的很快！"
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All
		rights reserved.</p>
</div>