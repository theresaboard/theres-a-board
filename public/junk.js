$(function(){
  $('#calendar').fullCalendar({
    events: {
      url: '/api/timeslots',
      type: 'GET',
    },
    error: function() {
        alert('there was an error while fetching events for calendar!');
    },
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    editable: true,
    eventLimit: true,
    selectable: true,
    select: function(start, end, allDay, ev) {
      //datetime object can be accessed by jquery method _d
      //start._d
      console.log(start);
      console.log(end);
      console.log(ev.data);
    },
    eventClick: function(event, jsEvent, view) {
      //datetime object can be accessed by jquery method _d
      //event._d
          //set the values and open the modal
    }
  });
  // var myCalendar = $('#my-calendar-id');
  // myCalendar.fullCalendar();
  // var myEvent = {
  //   title:"my new event",
  //   allDay: true,
  //   start: new Date(),
  //   end: new Date()
  // };
  // myCalendar.fullCalendar( 'renderEvent', myEvent );
});
