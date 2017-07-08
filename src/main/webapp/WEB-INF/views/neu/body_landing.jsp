<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
var tempEvent=null;
	$(document).ready(function() {
		$("#scheduleDialog").dialog({
			height: 250,
		      width: 350,
		      modal: true,
		      buttons: {
		        "确定": function(){
		        	if(tempEvent !=null){
						$('#calendar').fullCalendar('removeEvents', tempEvent._id);
						var eventData = {
								title: "已预约",
								start: tempEvent._start,
								end: tempEvent._end
							};
						$('#calendar').fullCalendar('renderEvent', eventData, true); 
						$("#scheduleDialog").dialog( "close" );
					} 
		        },
		        "取消": function() {
		          $("#scheduleDialog").dialog( "close" );
		        }
		      },
		      close: function() {
		    	  if(tempEvent !=null){
						$('#calendar').fullCalendar('removeEvents', tempEvent._id);
						tempEvent ==null;
					}      
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
			header: {title: "我的课表",
				left: null
				//,right: 'agendaWeek'
			},
			events:[{"color":"#ff9f89","start":"2017-04-03 18:23:13","end":"2017-07-02 07:00:00","id":"NA_a0"},{"color":"#ff9f89","start":"2017-07-04 12:00:00","end":"2017-07-05 08:00:00","id":"NA_a3"},{"color":"#ff9f89","start":"2017-07-05 12:00:00","end":"2017-07-07 09:00:00","id":"NA_a5"},{"color":"#ff9f89","start":"2017-07-11 12:00:00","end":"2018-02-03 18:23:13","id":"NA_a"}
			],
			eventRender: function(event, element) {
				if(event._id.indexOf("NA_")==0){
					element.text("");
					element.css("opacity",0.3);
				}else if(event._id =="temp"){
					tempEvent=event;
					element.text("设定中");
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
					$('#calendar').fullCalendar('renderEvent', eventData, true); 
				}
				$('#calendar').fullCalendar('unselect');
			},
			dayClick: function(date, allDay, jsEvent, view) {
				var stt = $.fullCalendar.formatDate(date, "YYYY-MM-DD HH:mm:ss");
				var ymdh = stt.substring(0,14);
				if(date._i[4]==30){
					ymdh+="59:59";
				}else{
					ymdh+="29:59";
				}
				var eventData = {
						id:"temp",
						start: stt,
						end: ymdh
					};
				if(tempEvent !=null){
					$('#calendar').fullCalendar('removeEvents', tempEvent._id);
				}
				$('#calendar').fullCalendar('renderEvent', eventData, true); 
				$.ajax({
					type : 'POST',
					//contentType : 'application/json',  
					url : 'cls/preSelectEvent',
					data : {
						startTime : stt
					},
					dataType : 'json',
					success : function(data) {
						console.log(JSON.stringfy(data));
						if (data.status == 'success') {
							
						} 
						$( "#scheduleDialog" ).dialog( "open" );
					},
					error : function(data) {
						$( "#scheduleDialog" ).dialog( "open" );
						console.log(JSON.stringfy(data));
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
					$('#calendar').fullCalendar('removeEvents', event._id);
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
	background-color:#f89600;
	color:#FFF !important;
	border: 0;
	border-radius:0;
	font-size:16px;
}

</style>

<div class="calendar_main_content_wrapper pure-u-1">
    <div class="box_bg" >
    	<div class="s_calendar_box calendar_date">
        	<div class="title">温馨提示：</div>
            <div class="schedule_tips">您下次上课时间是<span class="orange">2016-06-25 08：00</span>，请准时参与上课。</div>
            <p class="line"></p>
            <div class="schedule_tips"><span class="bold">L1级别定制套餐：</span>已上2课时，剩余5课时。</div>
            <a href="#" class="schedule_button">请准时进入教室</a>
        </div>
    </div>
    <div class="box_bg" >
    	<div class="s_calendar_box">
			<div id='calendar'> </div>
		</div>
	</div>
</div>

<div id="scheduleDialog" title="请选择课程内容">
<p class="validateTips"><label >上课时间</label><span id="timetext"></span></p>
  <form>
    <fieldset>
      <label for="name">选择教师</label>
      <select name="teacher" class="text ui-widget-content ui-corner-all">
      	<option value="300001">Ally Lee</option>
      	<option value="300002">Thomas Green</option>
      	<option value="300003">Kevin Moreland</option>
      </select>
      <label for="grade">选择课程</label>
      <select name="teacher" class="text ui-widget-content ui-corner-all">
      	<option value="L1">L1级别套餐</option>
      	<option value="L2">L2级别套餐</option>
      	<option value="L3">L3级别套餐</option>
      </select>
      <label for="password" >选择课题</label>
      <select name="teacher" class="text ui-widget-content ui-corner-all">
      	<option value="L1_A">L1 Practice ABC 课程</option>
      	<option value="L1_C">L1 Know your name 课程</option>
      	<option value="L1_C">L1 Lovely Animal 课程</option>
      </select>
    </fieldset>
  </form>
</div>

<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>