/* ------------------------------------------------------------------------------
*
*  # Fullcalendar basic options
*
*  Specific JS code additions for extra_fullcalendar_views.html and
*  extra_fullcalendar_styling.html pages
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */
$(function() {
  $('.fullcalendar-basic').fullCalendar({
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
      },
      editable: false,
      defaultView: 'agendaWeek',
      events: {
          url: '/api/timeslots',
          type: 'get'
      },
      selectable: true,
      select: function(start, end, allDay, ev) {
        ctrlr.getNewForm(ev);
      },
      eventClick: function(event, jsEvent, view) {
        var url = '/timeslots/' + event.id
        $('#modal_remote').modal({
            remote: url,
            show: true
        });
      }
  });

  $('.timepicker').pickatime({
    interval: 30
  });

  $('.datepicker').pickadate({
  });

  var CalendarShow = {};

  CalendarShow.Controller = function(){
    this.view = new CalendarShow.View('#calendar');
  };

  CalendarShow.Controller.prototype.getNewForm = function(event){
    $('#modal_new_timeslot').modal({ show: true });
  };

  CalendarShow.Controller.prototype.createDateTime = function (){
    var date = $('.timepicker').val();
    var time = $('.datepicker').val();
    var dateTime = date + " " + time;
    return (new Date(dateTime))
  };
  CalendarShow.Controller.prototype.createCalenderEvent = function(){
    var dateTimeObj = ctrlr.createDateTime();
    var newEvent = { title: 'booked appointment', start: dateTimeObj };
    $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
  };

  CalendarShow.Controller.prototype.postTimeslot = function(element){
    var dateTime = ctrlr.createDateTime();
    $.ajax({
      data: {timeslot: dateTime},
      type: 'POST',
      url: '/api/timeslots'
    }).then(function(response){
      $('#modal_new_timeslot').modal('toggle');
      ctrlr.createCalenderEvent();
    }).fail(function(){

    });
  };

  CalendarShow.View = function(element){
    this.setupListeners();
    this.element = $(element);
  };

  CalendarShow.View.prototype.setupListeners = function(){
    $('.modal-footer').on('click','button', function(e){
      e.preventDefault();
      if ($('timepicker').val() === ""){
        alert('please select a time.');
      }
      else{
        ctrlr.postTimeslot(this);
      };
    });
  };

  var ctrlr = new CalendarShow.Controller;
});
