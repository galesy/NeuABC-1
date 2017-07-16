<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
var prods=null;
var tempEvent=null;
var editEvent=null;
	$(document).ready(function() {
		$("#scheduleDetails").dialog({
			height: 250,
		      width: 350,
		      modal: true,
		      buttons: {
		        "取消上课": function(){
		        	$.ajax({
						type : 'POST',
						//contentType : 'application/json',  
						url : 'cls/cancelStudentClass',
						data : {
							startTime : $("#classStartTime").text()
						},
						dataType : 'json',
						success : function(data) {
							if (data.status == 'true') {
								if(editEvent !=null){
									$('#calendar').fullCalendar('removeEvents', editEvent._id);
									editEvent=null;
									$("#scheduleDetails").dialog( "close" );
								} 
							}else{
								$("#DetailError").text(data.msg);
							}							
						},
						error : function(data) {
							$("#DetailError").text("系统繁忙，请稍候再试");
						}
					});	
		        },
		        "开始上课": function(){
		        	$.ajax({
						type : 'POST',
						//contentType : 'application/json',  
						url : 'cls/studentStartClass',
						data : {
							startTime : $("#classStartTime").text(),
							tid: $("#tch_id").text(),
							tnick: $("#tch_nick").text()
						},
						dataType : 'json',
						success : function(data) {
							if (data.status == 'true') {
								window.open(data.clsUrl,'classroom');
								$("#scheduleDetails").dialog( "close" );
							}else{
								$("#DetailError").text(data.msg);
							}							
						},
						error : function(data) {
							$("#DetailError").text("系统繁忙，请稍候再试");
						}
					});	
		        },
		        "关闭": function() {
		          $("#scheduleDetails").dialog( "close" );
		        }
		      },
		      close: function() {  
		    	  $("#classStartTime").text("");
		    	  $("#tch_nick").text("");
		    	  $("#class_type").text("");
		    	  $("#class_name").text("");
		    	  $("#DetailError").text("");
		    	  $("#tch_id").text("");
		    	  $('.ui-dialog-buttonset').find('button:contains("取消上课")').show();
		    	  $('.ui-dialog-buttonset').find('button:contains("开始上课")').hide();
		    	  editEvent=null;
		      },
		      autoOpen: false,
		      show: {	effect: "blind",duration: 200}, hide: { effect: "blind", duration: 200  }
		 });
		$("#scheduleDialog").dialog({
			height: 250,
		      width: 350,
		      modal: true,
		      buttons: {
		        "确定": function(){
		        	$.ajax({
						type : 'POST',
						//contentType : 'application/json',  
						url : 'cls/reserveStudentClass',
						data : {
							startTime : $("#timetext").text(),
							tid: $("#tid").val(),
							pid:$("#pid").val()
						},
						dataType : 'json',
						success : function(data) {
							if (data.status == 'true') {
								if(tempEvent !=null){
									$('#calendar').fullCalendar('removeEvents', tempEvent._id);
									var eventData = {
											id:"Rsv_n"+tempEvent._start,
											txt: "已预约",
											start: tempEvent._start,
											end: tempEvent._end,
											color:"#4B824B"
										};
									$('#calendar').fullCalendar('renderEvent', eventData, false); 
									$("#scheduleDialog").dialog( "close" );
								} 
							}else{
								$("#SelectError").text(data.msg);
							}							
						},
						error : function(data) {
							$("#SelectError").text("系统繁忙，请稍候再试");
						}
					});	
		        },
		        "取消": function() {
		          $("#scheduleDialog").dialog( "close" );
		        }
		      },
		      close: function() {
		    	  clearClassSelection();
		    	  if(tempEvent !=null){
						$('#calendar').fullCalendar('removeEvents', tempEvent._id);
						tempEvent ==null;
					}      
		      },
		      autoOpen: false,
		      show: {	effect: "blind",duration: 200}, hide: { effect: "blind", duration: 200  }
		 });
		
		
		$('#calendar').fullCalendar({
			header: {title: "我的课表",
				left: null
				//,right: 'agendaWeek'
			},
			events:{
				url: 'cls/getTimeFrame',
				error: function(data) {
					console.log(data);
				}
			},
			eventRender: function(event, element) {
				if(event._id.indexOf("NA_")==0 ){
					element.text("");
					element.css("opacity",0.3);
				}else if(event._id =="temp"){
					tempEvent=event;
					element.text("设定");
					element.css("opacity",0.5);
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
			//selectable: true,
			selectHelper: false,
			selectOverlap:false,		
			slotEventOverlap:false,
			ignoreTimezone:false,
			select: function(start, end) {
				if(true){//confirm("Book for this time: "+start.format()+"?")){
					var eventData = {
							title: "已预约",
							start: start,
							end: end
						};
					$('#calendar').fullCalendar('renderEvent', eventData, false); 
				}
				$('#calendar').fullCalendar('unselect');
			},
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
				$('#calendar').fullCalendar('renderEvent', eventData, false); 
				$.ajax({
					type : 'POST',
					//contentType : 'application/json',  
					url : 'cls/preSelectEvent',
					data : {
						startTime : stt,
						getProd: prods==null?"Y":"N"
					},
					dataType : 'json',
					success : function(data) {
						$("#timetext").text(stt);
						if (data.status == 'true') {
							if(prods==null){
								prods = data.products;
							}
							initializeClassSelection(data);
						} else{
							$("#SelectError").text(data.msg);
						}	
						$( "#scheduleDialog" ).dialog( "open" );
					},
					error : function(data) {
						$("#SelectError").text("System unavailable.");
						$( "#scheduleDialog" ).dialog( "open" );
					}
				});
			},
			editable: false,
			eventLimit: true, 
			//monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
           // monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
            dayNames: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
            dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
            today: ["本周"],
            firstDay: 1,
            buttonText: {
                today: '本周',
                month: '月',
                week: '周',
                day: '日',
                prev: '上一周',
                next: '下一周'
            },
			loading: function(bool) {
				$('#loading').toggle(bool);
			},
			eventClick: function(event, jsEvent, view) {
				if(event._id.indexOf("NA_")!=0){
					$('.ui-dialog-buttonset').find('button:contains("取消上课")').hide();
			    	$('.ui-dialog-buttonset').find('button:contains("开始上课")').hide();
					if(event._id.indexOf("Rsv_")==0 ){
						$('.ui-dialog-buttonset').find('button:contains("取消上课")').show();
					}else if(event._id.indexOf("Run_")==0){
						$('.ui-dialog-buttonset').find('button:contains("开始上课")').show();
						$('.ui-dialog-buttonset').find('button:contains("开始上课")').css("background","#4B824B");
						$('.ui-dialog-buttonset').find('button:contains("开始上课")').css("color","#FFF");
						
					}
					editEvent=event;	
			    	$.ajax({
							type : 'POST',
							url : 'cls/getClassDetails',
							data : {
								startTime : event.start._i
							},
							dataType : 'json',
							success : function(data) {
								$("#classStartTime").text(event.start._i);
								if (data.status == 'true') {
							    	  $("#tch_nick").text(data.tnick);
							    	  $("#class_type").text(data.typename);
							    	  $("#class_name").text(data.pname);
							    	  $("#tch_id").text(data.tid)
								} else{
									$("#DetailError").text(data.msg);
								}	
								$( "#scheduleDetails" ).dialog( "open" );
							},
							error : function(data) {
								$("#DetailError").text("System unavailable.");
								$("#scheduleDetails").dialog( "open" );
							}
						});
			    	  
				}
					//$('#calendar').fullCalendar('removeEvents', event._id);
			},
			dayRender:function( date, cell ) { 
				$(cell).css('width','80px');
			}
		});
		
	});
	
	function initializeClassSelection (data){
		var tchers = data.teachers;
		if(typeof tchers !='undefined' && tchers.length>0){		
			$("#tid").empty(); 
			var currT = "";
			var count=0;
			for(var i=0;i<tchers.length;i++){
				if(currT !=tchers[i].tid && tchers[i].count < 1 ){
					$("#tid").append("<option value='"+tchers[i].tid+"'> "+tchers[i].tnick+" </option>"); 
					currT=tchers[i].tid;
					count++;
				}
			}
			if(count>0){
				$("#tid").change(function(){
					  var tid=$("#tid").val();
					  var ptype="";
					  $("#ptypeid").empty(); 
					  for(var i=0;i<tchers.length;i++){
						  if(tid == tchers[i].tid && ptype != tchers[i].ptypeid ){
							  ptype = tchers[i].ptypeid;
							  $("#ptypeid").append("<option value='"+tchers[i].ptypeid+"'> "+tchers[i].ptypename+" </option>"); 
						  }
					  }
					  $("#ptypeid").change();
				});
				if(count !=0){
					$("#tid").change();
				}
			}else{
				$("#tid").append("<option value=''>-暂时无可选老师-</option>"); 
			}
		}
	}
	
	function clearClassSelection(){
		$("#timetext").text("");
		$("#SelectError").text("");
		$("#tid").empty(); 
		$("#pid").empty(); 
		$("#ptypeid").empty(); 
		$("#tid").append("<option value=''>-暂时无可选老师-</option>"); 
		$("#ptypeid").append("<option value=''>-请选择课程类型-</option>"); 
		$("#pid").append("<option value=''>-请选择课题-</option>"); 
	}
	
	function generateProd(){
		 var ptypeid=$("#ptypeid").val();
		 $("#pid").empty(); 
		 var pid="";
		 for(var i=0;i<prods.length;i++){
			  if(ptypeid == prods[i].ptype && pid != prods[i].pid ){
				  pid = prods[i].pid;
				  $("#pid").append("<option value='"+prods[i].pid+"'> "+prods[i].pname+" </option>"); 
			  }
		  }
		 
	}

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


.fc-day {
	background-color:#efe;
}

.c-unthemed td.fc-today{
	background:#efe !important;
}
.popup p{
	margin-top:3px;
	margin-bottom:3px;
}

</style>

<div class="calendar_main_content_wrapper pure-u-1">
    <div class="box_bg" >
    	<div class="s_calendar_box calendar_date">
        	<div class="title">温馨提示：</div>
            <div class="schedule_tips">您下次上课时间是<span class="orange">2017-07-25 08：00</span>，请准时参与上课。</div>
            <p class="line"></p>
            <div class="schedule_tips"><span class="bold">L1级别定制套餐：</span>已上2课时，剩余5课时。</div>
            <a  class="schedule_button">请准时进入教室</a>
        </div>
    </div>
    <div class="box_bg" >
    	<div class="s_calendar_box">
			<div id='calendar'> </div>
		</div>
	</div>
</div>

<div id="scheduleDialog" class="popup" title="请选择课程内容">
<p class="validateTips"><label >上课时间</label><span id="timetext"></span></p>
  <form>
    <p>
      <label for="tid">选择教师</label>
      <select name="tid" id="tid" class="text ui-widget-content ui-corner-all">
      	<option value="">-暂时无可选老师-</option>
      </select>
    </p>
    <p>
      <label for="ptypeid">选择课程</label>
      <select name="ptypeid" id="ptypeid" class="text ui-widget-content ui-corner-all" onchange="javascript:generateProd()">
      	<option value="">-请选择课程类型-</option>
      </select>
    </p>
   <p>
      <label for="pid" >选择课题</label>
      <select name="pid" id="pid" class="text ui-widget-content ui-corner-all">
      	<option value="">-请选择课题-</option>
      </select>
      </p>
      <p id="SelectError" style="color:red;padding-top:6px"></p>
  </form>
</div>

<div id="scheduleDetails" class="popup" title="课堂详情">
   <p>时间：<span id="classStartTime"></span></p>
   <p>教师：<span id="tch_nick"></span><span id="tch_id" style="display:none"></span></p></p>
   <p>课程：<span id="class_type"></span></p></p>
   <p>课题：<span id="class_name"></span></p>
   <p id="DetailError" style="color:red;padding-top:6px"></p>
</div>

<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>