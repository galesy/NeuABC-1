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
			defaultDate: '2017-06-12',
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
<div id='calendar' style="width:800px"></div>