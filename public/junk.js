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
    eventLimit: true
  });

  //catches click existing event
  $('#calendar').on('click','.fc-content', function(){
    var moment = $(this).fullCalendar('getDate');
  });

  // $('#calendar').fullCalendar( 'renderEvent', event [, stick ] )
});
