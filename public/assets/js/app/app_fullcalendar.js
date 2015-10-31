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
            url: 'api/timeslots',
            type: 'get'
        },
        eventClick: function(event, jsEvent, view) {
            var url = '/timeslots/' + event.id
            $('#modal_remote').modal({
                remote: url,
                show: true
            });
        }
    });

});


// <a class="btn btn-default btn-sm" data-toggle="modal" href="/api/timeslots" data-target="#modal_remote">Launch <i class="icon-play3 position-right"></i></a>