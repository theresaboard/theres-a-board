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
    eventRender: function(event, element) {
        element.qtip({
            content: event.description
        });
    },
    eventClick: function(event) {
            // opens events in a popup window
            window.open(event.url, 'gcalevent', 'width=700,height=600');
            return false;
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
