<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
var tempEvent=null;
var editEvent=null;
	$(document).ready(function() {		
			$("#classDetails").dialog({
				height: 250,
			      width: 350,
			      modal: true,
			      buttons: {
			        "Cancel Class": function(){
			        	$.ajax({
							type : 'POST',
							//contentType : 'application/json',  
							url : 'cls/cancelTeacherClass',
							data : {
								startTime : $("#classStartTime").text()
							},
							dataType : 'json',
							success : function(data) {
								if (data.status == 'true') {
									if(editEvent !=null){
										$('#calendar').fullCalendar('removeEvents', editEvent._id);
										editEvent=null;
										$("#classDetails").dialog( "close" );
									} 
								}else{
									$("#DetailError").text(data.msg);
								}							
							},
							error : function(data) {
								$("#DetailError").text("System unavailable, please try again later.");
							}
						});	
			        },
			        "Enter Classroom": function(){
			        	$.ajax({
							type : 'POST',
							//contentType : 'application/json',  
							url : 'cls/teacherStartClass',
							data : {
								startTime : $("#classStartTime").text()
							},
							dataType : 'json',
							success : function(data) {
								if (data.status == 'true') {
									
								}else{
									$("#DetailError").text(data.msg);
								}							
							},
							error : function(data) {
								$("#DetailError").text("System Unavailable.");
							}
						});	
			        },
			        "Close": function() {
			          $("#classDetails").dialog( "close" );
			        }
			      },
			      close: function() {  
			    	  $("#classStartTime").text("");
			    	  $("#stc_nick").text("");
			    	  $("#class_type").text("");
			    	  $("#class_name").text("");
			    	  $("#DetailError").text("");		    	  
			    	  editEvent=null;
			      },
			      autoOpen: false,
			      show: {	effect: "blind",duration: 200}, hide: { effect: "blind", duration: 200  }
			 });
		
		
		$("#scheduleDialog").dialog({
			height: 225,
		      width: 350,
		      modal: true,
		      buttons: {
		        "Confirm": function(){
		        	$.ajax({
						type : 'POST',
						//contentType : 'application/json',  
						url : 'cls/tchConfirmDate',
						data : {
							startTime : $("#TimeConfirmS").text(),
		        			endTime: $("#TimeConfirmE").text()
						},
						dataType : 'json',
						success : function(data) {
							if (data.status == 'true') {
								if(tempEvent !=null){
									$('#calendar').fullCalendar('removeEvents', tempEvent._id);
									var eventData = {
											id:"Ava_"+tempEvent._start,
											txt: "Available",
											start: tempEvent._start,
											end: tempEvent._end,
											color: "#00C5CD"
										};
									$('#calendar').fullCalendar('renderEvent', eventData, true); 
									$("#scheduleDialog").dialog( "close" );
								} 
							}else{
								$("#scheduleError").text(data.msg);
							}							
							$( "#scheduleDialog" ).dialog( "close" );
						},
						error : function(data) {
							$("#scheduleError").text("System unavailable.");
						}
					});		        	
		        },
		        "Cancel": function() {
		          $("#scheduleDialog").dialog( "close" );
		        }
		      },
		      close: function() {
		    	  if(tempEvent !=null){
						$('#calendar').fullCalendar('removeEvents', tempEvent._id);
						tempEvent ==null;
				  }
		    	  $("#TimeConfirmS").text("");
		    	  $("#TimeConfirmE").text("");
		    	  $("#scheduleError").text("");
		      },
		      autoOpen: false,
		      show: {
		        effect: "blind",
		        duration: 200
		      },
		      hide: {
		        effect: "blind",
		        duration: 200
		      }});
		
		$("#deleteDialog").dialog({
			height: 225,
		      width: 350,
		      modal: true,
		      buttons: {
		        "Confirm": function(){
		        	$.ajax({
						type : 'POST',
						//contentType : 'application/json',  
						url : 'cls/tchDeleteTime',
						data : {
							startTime : $("#DeleteConfirmS").text(),
		        			endTime: $("#DeleteConfirmE").text()
						},
						dataType : 'json',
						success : function(data) {
							if (data.status == 'true') {
								if(tempEvent !=null){
									$('#calendar').fullCalendar('removeEvents', tempEvent._id);									
									$("#deleteDialog").dialog( "close" );
								} 
							}else{
								$("#DeleteError").text(data.msg);
							}							
							$( "#DeleteDialog" ).dialog( "close" );
						},
						error : function(data) {
							$("#DeleteError").text("System unavailable.");
						}
					});		        	
		        },
		        "Cancel": function() {
		          $("#deleteDialog").dialog( "close" );
		        }
		      },
		      close: function() {
		    	  if(tempEvent !=null){
						tempEvent ==null;
				  }
		    	  $("#DeleteConfirmS").text("");
		    	  $("#DeleteConfirmE").text("");
		    	  $("#DeleteError").text("");
		      },
		      autoOpen: false,
		      show: {
		        effect: "blind",
		        duration: 200
		      },
		      hide: {
		        effect: "blind",
		        duration: 200
		      }});
		
		
		
		$('#calendar').fullCalendar({
			header: {title: "My Calendar",
				left: null
				//,right: 'agendaWeek'
			},
			events:{
				url: 'cls/getTCalendar',
				error: function(data) {
					console.log(data);
				}
			},
			backgroundColor: "#cfe",
			eventRender: function(event, element) {
				if(event._id.indexOf("NA_")==0 ){
					element.text("");
					element.css("opacity",0.3);
				}else if(event._id =="temp"){
					tempEvent=event;
					element.text("Confirming");
					element.css("opacity",0.3);
				}
				if(typeof event.txt !="undefined"){
					element.text(event.txt);
				}
		    },
			//locale:"zh-CN",
			//theme: true,
			slotLabelFormat:"HH:mm",
			contentHeight:500,
			slotWidth:50,
			allDaySlot:false,
			defaultView:'agendaWeek',
			selectable: false,
			selectHelper: false,
			selectOverlap:false,		
			//slotEventOverlap:false,
			ignoreTimezone:false,			
			dayClick: function(date, allDay, jsEvent, view) {
				var stt = $.fullCalendar.formatDate(date, "YYYY-MM-DD HH:mm:ss");
				var ett = $.fullCalendar.formatDate(moment(date).add(30, 'm'), "YYYY-MM-DD HH:mm:ss");
				
				var eventData = {
						id:"temp",
						start: stt,
						end: ett
					};
				if(tempEvent !=null){
					$('#calendar').fullCalendar('removeEvents', tempEvent._id);
				}
				$('#calendar').fullCalendar('renderEvent', eventData, true); 
				$("#TimeConfirmS").text( stt );
				$("#TimeConfirmE").text( ett );
				$( "#scheduleDialog" ).dialog( "open" );
			},
			editable: false,
			eventLimit: true, 
			loading: function(bool) {
				$('#loading').toggle(bool);
			},
			eventClick: function(event, jsEvent, view) {
				//blocker area cannot be removed
				if(event._id.indexOf("NA_")==0){
					return;
				}else if(event._id.indexOf("Ava_")==0){//点击弹出确认删除窗口
					tempEvent = event;
					$("#DeleteConfirmS").text( event.start._i );
					$("#DeleteConfirmE").text( event.end._i );
					$( "#deleteDialog" ).dialog( "open" );
				}else {					
					$('.ui-dialog-buttonset').find('button:contains("Cancel Class")').hide();
			    	$('.ui-dialog-buttonset').find('button:contains("Enter Classroom")').hide();
					if(event._id.indexOf("Rsv_")==0 ){
						$('.ui-dialog-buttonset').find('button:contains("Cancel Class")').show();
					}else if(event._id.indexOf("Run_")==0){
						$('.ui-dialog-buttonset').find('button:contains("Enter Classroom")').show();
						$('.ui-dialog-buttonset').find('button:contains("Enter Classroom")').css("background","#4B824B");
						$('.ui-dialog-buttonset').find('button:contains("Enter Classroom")').css("color","#FFF");
					}
					editEvent=event;	
			    	$.ajax({
							type : 'POST',
							url : 'cls/getClassDetailt',
							data : {
								startTime : event.start._i
							},
							dataType : 'json',
							success : function(data) {
								$("#classStartTime").text(event.start._i);
								if (data.status == 'true') {
							    	  $("#stu_nick").text(data.snick);
							    	  $("#class_type").text(data.typename);
							    	  $("#class_name").text(data.pname);
								} else{
									$("#DetailError").text(data.msg);
								}	
								$( "#classDetails" ).dialog( "open" );
							},
							error : function(data) {
								$("#DetailError").text("System unavailable.");
								$("#classDetails").dialog( "open" );
							}
						});
				}				
			},
			dayRender:function( date, cell ) { 
				$(cell).css('width','80px');
			}
		});
		
	});

</script>
<style>

	body {
		margin: 0;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#script-warning {
		display: none;
		background: #eee;
		border-bottom: 1px solid #ddd;
		padding: 0 10px;
		line-height: 40px;
		text-align: center;
		font-weight: bold;
		font-size: 12px;
		color: red;
	}

	#loading {
		display: none;
		position: absolute;
		top: 10px;
		right: 10px;
	}

	#calendar {
		max-width: 900px;
		margin: 40px auto;
		padding: 0 10px;
	}
	
	.fc-widget-header{
		height:40px;
		background-color:#003399;
		color:#FFF;
		font-size:16px;
	}
.fc-event-container{
	margin:0 !important;
}
.fc-event{
	background-color:#FFA088;
	color:#FFF !important;
	border: 0;
	border-radius:0;
	font-size: 14px;
    text-align: center;
    padding-top: 2px;
}


.fc-day{
	background-color:#efe;
}

</style>

<div class="calendar_main_content_wrapper pure-u-1">    
    <div class="calendar_bg" >
    	<div class="s_calendar_box">
			<div id='calendar'> </div>
		</div>
	</div>
	<div class="box_bg" >
        <div class="calendar_main_box">
            <div class="calendar_title">Tips:</div>
            <p class="line"></p>
            <p class="calendar_tips_class"><span class="bold">Your curriculum:</span><span class="orange">the next time is 2016-06-25 08:00,</span>Please enter the classroom on time.</p>
            <p class="calendar_tips_class"><span class="bold">The last class time: </span>2016-06-10 07:00</p>
            <p class="calendar_tips_class"><span class="bold">The last class time: </span>2016-06-10 07:00</p>
            <p class="calendar_tips_class"><span class="bold">The last Class: </span>Family Matters / L1.Vernon's Questions</p>
            <p class="calendar_tips_class"><span class="bold">Students: </span></p>
            <div class="calendar_tips_student">
                <div class="calendar_tips_img">
                    <img src="<%=request.getContextPath()%>/static/neu/images/img1.png" />
                    <p class="img_name">Abby</p>
                </div>
                <div class="calendar_tips_img">
                    <img src="<%=request.getContextPath()%>/static/neu/images/img1.png" />
                    <p class="img_name">Abby</p>
                </div>
                <div class="calendar_tips_img">
                    <img src="<%=request.getContextPath()%>/static/neu/images/img1.png" />
                    <p class="img_name">Abby</p>
                    <div class="class_details calendar_class_details">
                        <div class="title">Personal data</div>
                        <div class="line"></div>
                        <div class="con">
                            <p>Name: Abby</p>
                            <p>Gender: Femal</p>
                            <p>Last class:Lelel1.Your are kind.</p>
                        </div>
                    </div>
                </div>
            </div>
            <a href="#" class="schedule_button">Enter the classroom</a>
        </div>
    </div>
</div>

<div id="scheduleDialog" title="Time Confirmation">
<p>Do you want to open this time period as available for student?</p>
<p>-</p>
<p ><b>Start:</b><span id="TimeConfirmS" style="padding-left:20px"></span ></p>
<p style="padding-top:4px"><b>End:</b><span id="TimeConfirmE" style="padding-left:25px" ></span ></p>
<p></p>
<p id="scheduleError" style="color:red;padding-top:6px"></p>
</div>

<div id="deleteDialog" title="Delete Confirmation">
<p>Do you want to remove this time from available list?</p>
<p>-</p>
<p ><b>Start:</b><span id="DeleteConfirmS" style="padding-left:20px"></span ></p>
<p style="padding-top:4px"><b>End:</b><span id="DeleteConfirmE" style="padding-left:25px" ></span ></p>
<p></p>
<p id="DeleteError" style="color:red;padding-top:6px"></p>
</div>

<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>
<div id="classDetails" class="popup" title="课堂详情">
   <p>时间：<span id="classStartTime"></span></p>
   <p>学生：<span id="stu_nick"></span></p></p>
   <p>课程：<span id="class_type"></span></p></p>
   <p>课题：<span id="class_name"></span></p>
   <p id="DetailError" style="color:red;padding-top:6px"></p>
</div>