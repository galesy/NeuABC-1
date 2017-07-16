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
        font-family: "robotolight";
    }	
</style> 
<div class="home_top_nav_wrapper pure-u-1">
	<div class="top">
	<span class="home_t_nav_logo pure-u-1-4"><a href="/" class="home_t_nav_logo_img"></a></span>
    <a href="<%=request.getContextPath() %>/signin" class="home_nav_button">Log In</a>
    </div>
	<ul class="home_t_nav_bar pure-u-1-2" style="margin-top: -27px;">
    	<li class="pure-menu-item"><a href="<%=request.getContextPath() %>" class="pure-menu-link sel">Home</a></li>
    	<li class="pure-menu-item"><a href="#" class="pure-menu-link">Blog</a></li>
    	<li class="pure-menu-item"><a href="#" class="pure-menu-link">FAQ</a></li>
    	<li class="pure-menu-item"><a href="#" class="pure-menu-link">Tech Reqs</a></li>
    </ul>    
</div>