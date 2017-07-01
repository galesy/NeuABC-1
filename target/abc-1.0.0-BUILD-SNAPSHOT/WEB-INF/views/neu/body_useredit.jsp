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
	String gen = user.getGen()==null?"U":user.getGen();
	
%>
<div class="person_main_content_wrapper pure-u-1">
	<div class="person_box pure-u-1">
        <div class="person_box_bg">
            <div class="person_title_main pure-u-1">
                <span class="title_text">个人资料</span>
            </div>
            <div class="person_edit_main">
                <form class="pure-form pure-form-aligned" action="<%=request.getContextPath()%>/editableuser" method="get">
                    <div class="pure-control-group">
                        <label for="name">姓名：</label>
                        <p class="person_date_text"><%= user.getNick()==null?"":user.getNick() %></p>
                    </div>
                    <div class="pure-control-group">
                        <label for="email">Email：</label>
                        <p class="person_date_text"><%= user.getEmailAddr()==null?"": user.getEmailAddr()%></p>
                    </div>
                    <div class="pure-control-group">
                        <label for="Age">性别：</label>
                        <label for="cb" class="pure-checkbox sel_checkbox">
                            <p class="person_date_text"><%=gen %></p>
                        </label>
                    </div>
                    <div class="pure-control-group">
                        <label for="Age">出生日期：</label>
                        <p class="person_date_text"><%=user.getDob()==null?"":user.getDob() %></p>
                    </div>
                    <div class="pure-control-group">
                        <label for="Url">头像：</label>
                        <label for="cb" class="pure-checkbox head_img_box">
                            <span class="head_img pure-img"><img src="<%=request.getContextPath() %>/static/neu/images/images/<%=user.getPhoto()==null?"girl-1252997_960_720.jpg":user.getPhoto() %> class=""/></span>
                        </label>
                    </div>
                    <div class="pure-controls">
                      <button class="pure-button pure-button-primary edit_button">编辑</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>