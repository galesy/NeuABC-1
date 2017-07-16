<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='GBK' />
<link href='<%=request.getContextPath() %>/static/external/css/fullcalendar.min.css' rel='stylesheet' />
<link href='<%=request.getContextPath() %>/static/external/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='<%=request.getContextPath() %>/static/external/js/moment.min.js'></script>
<script src='<%=request.getContextPath() %>/static/external/js/jquery.js'></script>
<script src='<%=request.getContextPath() %>/static/external/js/fullcalendar.min.js'></script>
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
			slotWidth:30,
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

</style>
</head>
<body>
	<div id='calendar' style="width:600px"></div>
</body>
</html>
