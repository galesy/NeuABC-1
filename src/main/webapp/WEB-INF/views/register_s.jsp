<script>
$.validator.setDefaults({
    submitHandler: function() {
      $.ajax( {  
        type : 'POST',  
        //contentType : 'application/json',  
        url : 'doRegister',  
        data : { 
        	phone: $("#phone").val(),
        	password:$("#password").val(),
        	agree:$("#agree").val(),
        	email:$("#email").val(),
        	smsverify:$("#smscode").val() 
        },  
        dataType : 'json',  
        success : function(data) { 
        	if(data.status == 'Success'){
        		location.href="/abc/tiles";
        	}else{
        		$().show();
        	}
        },  
        error : function(data) {  
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
			},
			email:{
				required: true
			},
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

<form id="loginForm" name="loginForm" action="doLogin" method="post" >
<div style="text-aligh:center;border:0" >
	<fieldset>
			<legend>Student Register Page</legend>
			<p>
				<label for="phone">Phone Number</label>
				<input id="phone" name="phone" type="text" required="true" aria-required="true" class="error" aria-invalid="true">
				<label id="cname-error" class="error" for="cname">User is not found! Please try again</label>
			</p>
			<p>
				<label for="password">Password</label>
				<input id="password" type="password" name="password" required="true" aria-required="true">
			</p>
<!-- 			<p> -->
<!-- 				<label for="password2">Confirm Password</label> -->
<!-- 				<input id="password2" type="password2" name="password2" required="true" aria-required="true"> -->
<!-- 			</p> -->
			<p>
				<label for="smscode">Verify Code</label>
				<input id="smscode" type="email" name="smscode" >
			</p>
			<p>
				<label for="agree">
					<input type="checkbox" id="agree" value="Y" name="agree" />You agree that you have read our privacy policy.
				</label>
			</p>
			<p>
				<input class="submit" type="submit" value="Sign In">
			</p>
		</fieldset>
</div>
</form>