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
$(document).ready(function(){
$(function() {

    // Initialization
    // ------------------------------

    // Basic view
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
      }
  });
  $('.timepicker').pickatime({
    interval: 30
  });
  $('.datepicker').pickadate({
    // interval: 30
  });
  var CalendarShow = {};

  CalendarShow.Controller = function(){
    this.view = new CalendarShow.View('#calendar');
  };

  CalendarShow.Controller.prototype.getNewForm = function(event){
    // var url = '/api/timeslots/' + event.id;
    $('#modal_remote').modal({
      // remote: url,
      show: true
    });
  };

  CalendarShow.Controller.prototype.createCalenderEvent = function(){
    var dateTimeObj = new Date($('#timeslot_start').val());
    var newEvent = { title: 'booked appointment', start: dateTimeObj };
    $('#calendar').fullCalendar('renderEvent', newEvent, 'stick');
  };

  CalendarShow.Controller.prototype.postTimeslot = function(element){
    var time = $('.timepicker').val();
    var date = $('.datepicker').val();
    var dateTime = date + " " + time;
    dateTime = new Date(dateTime)
    $.ajax({
      data: {timeslot: dateTime},
      type: 'POST',
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
    // $('.modal-body ul').on('click', function(e){
    //   e.preventDefault();
    //   debugger;
    //   ctrlr.postTimeslot(this);
    // });
    $('.modal-footer').on('click','button', function(e){
      e.preventDefault();
      if ($('timepicker').val() === ""){
        alert('please select a time.')
      }
      else{
        ctrlr.postTimeslot(this);
      };
    });

  };

  var ctrlr = new CalendarShow.Controller;
});
});

// <a class="btn btn-default btn-sm" data-toggle="modal" href="/api/timeslots" data-target="#modal_remote">Launch <i class="icon-play3 position-right"></i></a>
