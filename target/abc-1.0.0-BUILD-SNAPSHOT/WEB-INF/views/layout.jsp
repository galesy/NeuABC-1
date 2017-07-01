<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Simple Layout Demo</title>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/static/external/css/layout-default.css">
<style>
div.menu ul  
{  
    list-style:none; 
    margin: 0px; 
    padding: 0px; 
    width: auto; 
}  
div.menu ul li  
{  
    float:left; 
}  
 
div.menu ul li a, div.menu ul li a:visited  
{  
    background-color: #FFF;
    border: 0; 
    color: #336699; 
    display: block;   
    line-height: 1.35em;
    padding: 4px 20px;
    text-decoration: none;
    white-space: nowrap; 
}  
div.menu ul li a:hover  
{  
    background-color: #ffddee;
    color: #336699; 
    text-decoration: none;
    cursor:pointer;
}   
div.menu ul li a:active  
{  
    background-color: #f1f1f1; 
    color: #336699; 
    text-decoration: none;
} 
</style>
<link href='<%=request.getContextPath() %>/static/external/css/fullcalendar.min.css' rel='stylesheet' />
<link href='<%=request.getContextPath() %>/static/external/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='<%=request.getContextPath() %>/static/external/js/moment.min.js'></script>
<script src='<%=request.getContextPath() %>/static/external/js/jquery.js'></script>
<script src='<%=request.getContextPath() %>/static/external/js/fullcalendar.min.js'></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/static/external/js/jquery.layout.js"></script>

<script type="text/javascript">
	var myLayout;

	$(document).ready(function() {
		myLayout = $('body').layout({
			west__minSize : 300,
			east__minSize : 200,
			north__minSize : 70,
			spacing_open : 0

		});

	});
</script>
<script>

	$(document).ready(function() {
	
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay,listWeek'
			},
			Duration:"01:00:00",
			contentHeight:300,
			slotWidth:40,
			allDaySlot:false,
			defaultDate: '2017-05-12',
			defaultView:'agendaWeek',
			selectable: true,
			selectHelper: false,
			selectOverlap:false,
			select: function(start, end) {
				if(true){//confirm("Book for this time: "+start.format()+"?")){
					var eventData = {
							title: "Booked",
							start: start,
							end: end
						};
					$('#calendar').fullCalendar('renderEvent', eventData, true); 
				}
				$('#calendar').fullCalendar('unselect');
			},
			editable: true,
			eventLimit: true, 
			loading: function(bool) {
				$('#loading').toggle(bool);
			},
			dayClick: function(date, allDay, jsEvent, view) {
					console.log(date);
			},
			eventClick: function(event, jsEvent, view) {
				$('#calendar').fullCalendar('removeEvents', event._id);
			},
			dayRender:function( date, cell ) { 
				$(cell).css('width','50px');
			},
			eventRender:function(event, element, view) {
                //$(element).css('width','50px');
            }
		});
		
	});

</script>
</head>
<body>

	<!-- manually attach allowOverflow method to pane -->
	<div class="ui-layout-north"
		style="border: 0; padding-left: 30px; padding-top: 20px">
		<div style="float:left; ">
		<img
			src="<%=request.getContextPath()%>/static/neu/images/home_Logo.png">
			</div>
			<div style="margin-left:200px;text-align:center;display:inline-block">
			<div class="menu" >
				<ul>
					<li><a><spring:message code="home"></a></spring:message></li>
					<li><a><spring:message code="class_series"></a></spring:message></li>
					<li><a><spring:message code="north_us_teacher"></a></spring:message></li>
					<li><a><spring:message code="open_classes"></a></spring:message></li>
				</ul>
			</div>
		</div>
		<div style="float:right;display:inline-block ">
			<div>
			<a style="color:#336699;cursor:pointer">
			<strong><b><spring:message code="login"></b></strong>
			</a></spring:message><a style="color:#336699;cursor:pointer;margin-left:10px">
			<strong><b><spring:message code="register"></spring:message></b></strong>
			</a></div>
			
		</div>

	</div>

	<div class="ui-layout-west" style="border: 0;background-color:#f5f5f5">
<!-- 		West -->
<!-- 		<p> -->
<!-- 			<button onclick="myLayout.close('west')">Close Me</button> -->
<!-- 		</p> -->
	</div>

	<div class="ui-layout-south" style="border: 0;background-color:#f5f5f5">
<!-- 		South -->
<!-- 		<p> -->
<!-- 			<button onclick="myLayout.toggle('north')">Toggle North Pane</button> -->
<!-- 		</p> -->
	</div>

	<div class="ui-layout-east" style="border: 0;background-color:#f5f5f5">
<!-- 		East -->
<!-- 		<p> -->
<!-- 			<button onclick="myLayout.close('east')">Close Me</button> -->
<!-- 		</p> -->

	</div>

	<div class="ui-layout-center" style="border: 0;background-color:#f5f5f5">
		<div id='calendar' style="width:800px"></div>
	</div>

</body>
</html>