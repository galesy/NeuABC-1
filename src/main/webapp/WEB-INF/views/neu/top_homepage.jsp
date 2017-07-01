<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /*
    When setting the primary font stack, apply it to the Pure grid units along
    with `html`, `button`, `input`, `select`, and `textarea`. Pure Grids use
    specific font stacks to ensure the greatest OS/browser compatibility.
    */
    body, html, button, input, select, textarea,
    .pure-g [class *= "pure-u"] {
        /* Set your content font stack here: */
        font-family: "robotolight","微软雅黑";
    }	
</style> 
<div class="home_top_nav_wrapper pure-u-1">
	<div class="top">
	<span class="home_t_nav_logo pure-u-1-4"><a href="<%=request.getContextPath() %>" class="home_t_nav_logo_img"></a></span>
    <a href="<%=request.getContextPath() %>/login" class="home_nav_button">登录</a>
    </div>
	<ul class="home_t_nav_bar pure-u-1-2" style="margin-top: -27px;">
    	<li class="pure-menu-item"><a href="<%=request.getContextPath() %>" class="pure-menu-link sel">首页</a></li>
    	<li class="pure-menu-item"><a href="#" class="pure-menu-link">课程体系</a></li>
    	<li class="pure-menu-item"><a href="#" class="pure-menu-link">北美师资</a></li>
    	<li class="pure-menu-item"><a href="#" class="pure-menu-link">公开课</a></li>
    </ul>    
</div>