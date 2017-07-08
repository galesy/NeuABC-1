<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0 maximum-scale=1.0, user-scalable=1;" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/static/neu/css/css.css">
<link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/base-min.css">
<!--[if lte IE 8]>
  <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/base-min.css">
  <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/grids-min.css">
  <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/grids-responsive-old-ie-min.css">
<![endif]-->
<!--[if gt IE 8]><!-->
  <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/base-min.css">
  <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/grids-min.css">
  <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/grids-responsive-min.css">
<!--<![endif]-->
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
</head>
<body>
<div class="home_top_nav_wrapper home_all pure-u-1">
	<a class="home_top_nav_logo" href="<%=request.getContextPath() %>"></a>    
</div>
<div class="home_main_content_wrapper pure-u-1">
	<div class="home_main_content_banner_title pure-u-1">
        <span class="bird_s"></span>
        <span class="bird"></span>
    	<span class="text pure-u-1">NeuABC</span>
        <span class="cloud"></span>
    </div>
    <div class="home_main_content_banner_selbox pure-u-1">
    	<div class="home_main_content_banner_sel home_main_content_banner_sel_all pure-u-3-4 pure-u-xl-1-2">
            <a href="stu" class="home_main_content_banner_s pure-button pure-u-sm-2-5 pure-u-4-5"><i class="student"></i>我是学生</a>
            <a href="tch" class="home_main_content_banner_t pure-button pure-u-sm-2-5 pure-u-4-5"><i class="teacher"></i>I'm a teacher</a>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright © 2017 JSU Technology. All rights reserved. </p>
</div>
</body>
</html>
