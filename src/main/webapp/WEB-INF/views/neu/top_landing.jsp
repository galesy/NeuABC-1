<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.neu.abc.utils.Constants" %>
<%@ page import="com.neu.abc.model.User" %>
<style>
    /*
    When setting the primary font stack, apply it to the Pure grid units along
    with `html`, `button`, `input`, `select`, and `textarea`. Pure Grids use
    specific font stacks to ensure the greatest OS/browser compatibility.
    */
	body, html, button, input, select, textarea,
    .pure-g [class *= "pure-u"] {
        /* Set your content font stack here: */
        font-family: "robotolight";
    }	
</style> 
<%
User user = (User)session.getAttribute(Constants.SESSION_USER);
if(user == null){
	response.sendRedirect("home");
}
String iconPath = user.getPhoto()==null?"girl-1252997_960_720.jpg":user.getPhoto();
%>
<div class="signin_top_nav_wrapper pure-u-1">
	<div class="top">
	<span class="home_t_nav_logo pure-u-1-4"><a href="<%=request.getContextPath() %>" class="home_t_nav_logo_img"></a></span>
    <ul class="person_top_nav_bar">
		<li class="pure-menu-item"><img class="nav_user pure-img" src="<%=request.getContextPath()%>/static/neu/images/photo/<%= iconPath%>" /></li>
    	<li class="pure-menu-item"><a href="<%=request.getContextPath()%>/logout" class="pure-menu-link ">退出</a></li>
    	<li class="pure-menu-item"><a href="<%=request.getContextPath()%>/edituser" class="pure-menu-link <% if("edituser".equals(request.getParameter("tab") ) ) {%>sel<%} %>">个人资料</a></li>
    	<li class="pure-menu-item"><a href="<%=request.getContextPath()%>/prodintro" class="pure-menu-link <% if("schedule".equals(request.getParameter("tab") ) ) {%>sel<%} %>">约课</a></li>
    	<li class="pure-menu-item"><a href="<%=request.getContextPath()%>/landing" class="pure-menu-link <% if("landing".equals(request.getParameter("tab")) ) {%>sel<%} %>">我的日程</a></li>
    </ul> 
    </div>
</div>