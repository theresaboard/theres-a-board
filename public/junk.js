$(document).ready(function(){
  var CalendarShow = {};

  CalendarShow.Controller = function(){
    this.view = new CalendarShow.View('#calendar');
  };

  CalendarShow.Controller.prototype.getNewForm = function(start){
    $('#new_timeslot_div').css('visibility', 'visible');
    $('#timeslot_start').val(start._d);
  };
  CalendarShow.Controller.prototype.createCalenderEvent = function(){
    var dateTimeObj = new Date($('#timeslot_start').val());
    var newEvent = { title: 'booked appointment', start: dateTimeObj };
    $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
  };
  CalendarShow.Controller.prototype.postTimeslot = function(element){
    $.ajax({
      data: $(element).serialize(),
      type: 'post',
      url: '/api/timeslots'
    }).then(function(response){
      $('#new_timeslot_div').css('visibility', 'hidden');
      ctrlr.createCalenderEvent();
    }).fail(function(){

    });
  };

  CalendarShow.View = function(element){
    this.setupListeners();
    this.element = $(element);
  };

  CalendarShow.View.prototype.setupListeners = function(){
    $('#new_timeslot_div').on('submit','#new_timeslot_form', function(e){
      e.preventDefault();
      ctrlr.postTimeslot(this);
    });
  };

  var ctrlr = new CalendarShow.Controller;

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
        ctrlr.getNewForm(start);
      },
      eventClick: function(event, jsEvent, view) {
        //datetime object can be accessed by jquery method _d
        //event._d
            //set the values and open the modal
      }
    });
  });
});
