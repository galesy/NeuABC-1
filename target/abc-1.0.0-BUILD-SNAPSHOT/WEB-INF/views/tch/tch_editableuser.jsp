<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.neu.abc.utils.Constants" %>
<%@ page import="com.neu.abc.model.User" %>
<%
	User user = (User)session.getAttribute(Constants.SESSION_USER);
	if(user == null){
		response.sendRedirect("home");
	}
	String gen = user.getGen()==null?"U":(user.getGen().toUpperCase());
	String iconPath = user.getPhoto()==null?"":(request.getContextPath()+"/static/neu/images/photo/"+user.getPhoto());
	
%>
<script type="text/javascript">

	$(document).ready(function() {
		$.validator.setDefaults({
			submitHandler : function() {
				//return;
			}
		});
		
// 		$("#profileForm").validate({
// 				//debug:true,
// 				rules : {
// 					email : {
// 						required:true,
// 						email : true
// 					},
// 				},
// 				messages : {
// 					email : {
// 						email : "Please enter a valid email address"
// 					}
// 				},
// 				errorElement : "em",
// 				errorPlacement : function(error, element) {
// 					error.appendTo(element.parent().children().last());
// 				}

// 			});
		
		$( "#dob" ).datepicker( {
			numberOfMonths:1,//显示几个月  
            showButtonPanel:true,//是否显示按钮面板  
            yearRange:'c-40:c',//前30年和后10年
            changeMonth: true,
            changeYear: true,
            dateFormat: 'yy-mm-dd',//日期格式  
            showMonthAfterYear:true,//是否把月放在年的后面 
            minDate:'1950-01-01'//最小日期  
            //maxDate:'2011-03-20',//最大日期  
		});

	});
	

</script>
<div class="person_main_content_wrapper pure-u-1">
	<div class="person_box pure-u-1">
        <div class="person_box_bg">
            <div class="person_title_main pure-u-1">
                <span class="title_text">Personal Profile</span>
            </div>
            <div class="person_edit_main">
                <form class="pure-form pure-form-aligned" enctype="multipart/form-data" name="profileForm" id="profileForm"
                	method="post" action="<%=request.getContextPath()%>/profileupload">
                    <div class="pure-control-group">
                        <label for="nick">Full Name</label>
                        <input id="nick" name="nick" class="Name" type="text" placeholder="Full Name" value="<%= user.getNick()==null?"":user.getNick() %>">
                    </div>
                    <div class="pure-control-group">
                        <label for="email">Email</label>
                        <input id="email" name="email" type="email" placeholder="Email" value="<%= user.getEmailAddr()==null?"": user.getEmailAddr()%>" required>
                        
                    </div>
                    <div class="pure-control-group">
                        <label >Gender</label>
                        <label for="gen1" class="pure-checkbox sel_checkbox">
                            <input name="gen" id="gen1" type="radio" value="M" <% if("M".equalsIgnoreCase(gen)) { %>checked<%} %>>Male
                        </label>
                        <label for="gen2" class="pure-checkbox sel_checkbox">
                            <input name="gen" id="gen2" type="radio" value="F" <% if("F".equalsIgnoreCase(gen)) { %>checked<%} %>>Female
                        </label>
                        <label for="gen3" class="pure-checkbox sel_checkbox">
                            <input name="gen" id="gen3" type="radio" value="U" <% if("U".equalsIgnoreCase(gen)) { %>checked<%} %>>Secrecy
                        </label>
                    </div>
                    <div class="pure-control-group">
                        <label for="Age">Date of Birth</label>
                        <input type="text" name="dob" id="dob" value="<%=user.getDob()==null?"":user.getDob()%>" readonly />             
                    </div>
                    <div class="pure-control-group">
                        <label >Photo</label>
                        <label class="pure-checkbox head_img_box">
                            <img src="<%=iconPath%>"  class="head_img pure-img"/>
                            <input type="file" name="usericon" id="usericon" />
                        </label>
                    </div>
                    <div class="pure-controls">
                        <button type="submit" class="pure-button pure-button-primary sign_button">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>