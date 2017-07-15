<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {	
	var preDiv = null;
	$(".list_title").click(function(){
		
		if($(this).parent().find(".list_con").is(':visible')){
			$(this).parent().removeClass("list_show");
			$(this).parent().find(".list_con").hide();
			$(this).find(".icon_show").removeClass("icon_show").addClass("icon");
		}else{
			$(this).parent().find(".list_con").show();
			$(this).parent().addClass("list_show");
			$(this).find(".icon").addClass("icon_show");
		}
		console.log();
	})
	
});
</script>
<div class="calendar_main_content_wrapper pure-u-1">
    <div class="calendar_bg" >
        <div class="calendar_main_box">
            <div class="calendar_title">Curriculum</div>
            <p class="calendar_tips">Tip：Choose to teach the courses, there are different Levels under each course.</p>
            <p class="line"></p>
            <div class="main_list">
                <div class=" list list_show">
                    <div class="list_title">
                        <div class="title">Family Matters</div>
                        <span class="icon_show"></span>
                    </div>
                    <div class="list_con">
                    	<div class="list_con_list">
                            <input name="v1" id="v11" type="radio" value="1">
                            <div class="class" >L1.Vernon's Questions</div>
                        </div>
                    	<div class="list_con_list">
                            <input name="v1" id="v12" type="radio" value="2">
                            <div class="class" >L2.Dear Tooth Fairy</div>
                        </div>
                    </div>
                </div>
                <div class="list">
                    <div class="list_title">
                        <div class="title">First Americans: Native Peoples and the Land</div>
                        <span class="icon"></span>
                    </div>
                    <div class="list_con" style="display:none">
                    	<div class="list_con_list">
                            <input name="v1" id="v11" type="radio" value="1">
                            <div class="class" >L1.Where are you going</div>
                        </div>
                    	<div class="list_con_list">
                            <input name="v1" id="v12" type="radio" value="2">
                            <div class="class" >L2.Go Shopping</div>
                        </div>
                    </div>
                </div>
                <div class="list">
                    <div class="list_title">
                        <div class="title">Folktales from Around the World</div>
                        <span class="icon"></span>
                    </div>
                    <div class="list_con" style="display:none">
                    	<div class="list_con_list">
                            <input name="v1" id="v11" type="radio" value="1">
                            <div class="class" >L1.Where does it from</div>
                        </div>
                    	<div class="list_con_list">
                            <input name="v1" id="v12" type="radio" value="2">
                            <div class="class" >L2.Public transportation</div>
                        </div>
                    </div>
                </div>
                <div class="list">
                    <div class="list_title">
                        <div class="title">Amazing Animals</div>
                        <span class="icon"></span>
                    </div>
                    <div class="list_con" style="display:none">
                    	<div class="list_con_list">
                            <input name="v1" id="v11" type="radio" value="1">
                            <div class="class" >L1.Go to the zoo</div>
                        </div>
                    	<div class="list_con_list">
                            <input name="v1" id="v12" type="radio" value="2">
                            <div class="class" >L2.Why I am different</div>
                        </div>
                    </div>
                </div>
                <div class="list">
                    <div class="list_title">
                        <div class="title">Know your world</div>
                        <span class="icon"></span>
                    </div>
                    <div class="list_con" style="display:none">
                    	<div class="list_con_list">
                            <input name="v1" id="v11" type="radio" value="1">
                            <div class="class" >L1.A colorful map</div>
                        </div>
                    	<div class="list_con_list">
                            <input name="v1" id="v12" type="radio" value="2">
                            <div class="class" >L2.The Seasons</div>
                        </div>
                    </div>
                </div>
                <div class="pure-controls">
                    <p class="calendar_button pure-u-1" ><a  class="pure-u-1-4">Submit</a></p>
                </div>
            </div>
        </div>
    
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright © 2017 NP Technology. All rights reserved. </p>
</div>

