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
      timezone: 'local',
      editable: false,
      defaultView: 'agendaWeek',
      events: {
          url: '/api/timeslots',
          type: 'get'
      },
      selectable: true,
      select: function(start, end, allDay, ev){
        ctrlr.getNewForm(start._d);
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
    this.view = new CalendarShow.View('.fullcalendar-basic');
  };

  CalendarShow.Controller.prototype.getNewForm = function(dateTimeObj){
    $('#modal_new_timeslot').modal({ show: true });
    $('.datepicker').val(ctrlr.dateCreate(dateTimeObj));
    $('.timepicker').val(ctrlr.timeCreate(dateTimeObj));
  };

  CalendarShow.Controller.prototype.dateCreate = function(dateTimeObj){
    var fullDate = dateTimeObj;
    var day = fullDate.getDate().toString();
    var months = [ "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December" ];
    var month = months[fullDate.getMonth()];
    var year = fullDate.getFullYear().toString();
    return (day + ' ' + month + ', ' + year);
  };
  CalendarShow.Controller.prototype.timeCreate = function(dateTimeObj){
    var fullDate = dateTimeObj;
    var hours = fullDate.getHours().toString();
    var minutes = fullDate.getMinutes();
    if (minutes > 15 && minutes < 45){
      minutes = '30';
    }
    else if (minutes >= 45 || (minutes >= 0 && minutes <= 15)){
      minutes = '00';
    };
    var ampm = hours >= 12 ? 'pm' : 'am';
    hours = hours % 12;
    hours = hours ? hours : 12;
    return (hours + ':' + minutes + ' ' + ampm);
  };

  CalendarShow.Controller.prototype.createDateTime = function (){
    var date = $('.timepicker').val();
    var time = $('.datepicker').val();
    var dateTime = date + " " + time;
    return (new Date(dateTime))
  };
  CalendarShow.Controller.prototype.createCalenderEvent = function(){
    var dateTimeObj = ctrlr.createDateTime();
    var newEvent = { title: 'New session created!', start: dateTimeObj };
    $('.fullcalendar-basic').fullCalendar('renderEvent', newEvent, 'stick');
  };

  CalendarShow.Controller.prototype.postTimeslot = function(element){
    var dateTime = ctrlr.createDateTime();
    $.ajax({
      data: { timeslot: dateTime },
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
    $('#create-timeslot').on('click', function(e){
      e.preventDefault();
      if ($('.timepicker').val() === ""){
        alert('Please select a time.');
      }
      else{
        ctrlr.postTimeslot(this);
      };
    });
  };

  var ctrlr = new CalendarShow.Controller;

  // Fix for modals not changing between shows
  $('body').on('hidden.bs.modal', '.modal', function () {
    $(this).removeData('bs.modal');
  });


});
