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
	String gen = user.getGen()==null?"U":("M".equalsIgnoreCase(user.getGen())?"男":"女");
	String iconPath = user.getPhoto()==null?"":(request.getContextPath()+"/static/neu/images/"+user.getPhoto());
	
%>
<script type="text/javascript">

	$(document).ready(function() {
		$( "#dob" ).datepicker( {
			numberOfMonths:1,//显示几个月  
            showButtonPanel:true,//是否显示按钮面板  
            yearRange:'c-40:c',//前30年和后10年
            changeMonth: true,
            changeYear: true,
            dateFormat: 'yy-mm-dd',//日期格式  
            clearText:"清除",//清除日期的按钮名称  
            closeText:"关闭",//关闭选择框的按钮名称  
            yearSuffix: '年', //年的后缀  
            showMonthAfterYear:true,//是否把月放在年的后面 
            minDate:'1950-01-01'//最小日期  
            //maxDate:'2011-03-20',//最大日期  
		})

	});
	

	jQuery(function($){
		$.datepicker.regional['zh-CN'] = {
			closeText: '关闭',
			prevText: '<上月',
			nextText: '下月>',
			currentText: '今天',
			monthNames: ['一月','二月','三月','四月','五月','六月',
			'七月','八月','九月','十月','十一月','十二月'],
			monthNamesShort:['一月','二月','三月','四月','五月','六月',
				'七月','八月','九月','十月','十一月','十二月'],
			dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
			dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
			dayNamesMin: ['日','一','二','三','四','五','六'],
			weekHeader: '周',
			dateFormat: 'yy-mm-dd',
			firstDay: 1,
			isRTL: false,
			showMonthAfterYear: true,
			yearSuffix: '年'};
		$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
	});
</script>
<div class="person_main_content_wrapper pure-u-1">
	<div class="person_box pure-u-1">
        <div class="person_box_bg">
            <div class="person_title_main pure-u-1">
                <span class="title_text">个人资料</span>
            </div>
            <div class="person_edit_main">
                <form class="pure-form pure-form-aligned" enctype="multipart/form-data" name="profileForm" id="profileForm"
                	method="post" action="<%=request.getContextPath()%>/profileupload">
                    <div class="pure-control-group">
                        <label for="nick">姓名</label>
                        <input id="nick" name="nick" class="Name" type="text" placeholder="姓名" value="<%= user.getNick()==null?"":user.getNick() %>">
                    </div>
                    <div class="pure-control-group">
                        <label for="email">Email</label>
                        <input id="email" type="email" placeholder="Email" value="<%= user.getEmailAddr()==null?"": user.getEmailAddr()%>">
                    </div>
                    <div class="pure-control-group">
                        <label >性别</label>
                        <label for="gen1" class="pure-checkbox sel_checkbox">
                            <input name="gen" id="gen1" type="radio" value="M" <% if("M".equalsIgnoreCase(gen)) { %>checked<%} %>>男
                        </label>
                        <label for="gen2" class="pure-checkbox sel_checkbox">
                            <input name="gen" id="gen2" type="radio" value="F" <% if("F".equalsIgnoreCase(gen)) { %>checked<%} %>>女
                        </label>
                        <label for="gen3" class="pure-checkbox sel_checkbox">
                            <input name="gen" id="gen3" type="radio" value="U" <% if("U".equalsIgnoreCase(gen)) { %>checked<%} %>>保密
                        </label>
                    </div>
                    <div class="pure-control-group">
                        <label for="Age">出生日期</label>
                        <input type="text" name="dob" id="dob" value="<%=user.getDob()==null?"":user.getDob()%>" readonly />             
                    </div>
                    <div class="pure-control-group">
                        <label >头像</label>
                        <label class="pure-checkbox head_img_box">
                            <img src="<%=iconPath%>"  class="head_img pure-img"/>
                            <input type="file" name="usericon" id="usericon" />
                        </label>
                    </div>
                    <div class="pure-controls">
                        <button type="submit" class="pure-button pure-button-primary sign_button">提交</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright © 2017 NP Technology. All rights reserved. </p>
</div>