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
    // eventClick: function(event, jsEvent, view) {
    //       //set the values and open the modal
    //       debugger;
    //       $("#eventInfo").html(event.description);
    //       $("#eventLink").attr('href', event.url);
    //       $("#eventContent").dialog({ modal: true, title: event.title });
        // }
  });
  $('new_timeslot_button').click(function(){});
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
