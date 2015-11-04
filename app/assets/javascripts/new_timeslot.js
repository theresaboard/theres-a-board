$(document).ready(function(){

  $("#new-timeslot-form").submit(function(event){
    event.preventDefault();
    var data = createDate();
    $("#modal_new_timeslot").modal('toggle');
    $.ajax({
        type: "POST",
        url: "/api/timeslots",
        data: { start: data },
        beforeSend: customBlockUi(this)
      }).done(function(response) {
          swal({
                title: "Great!",
                text: "You have set up a tutoring availability!",
                confirmButtonColor: "#66BB6A",
                type: "success"
            });
          $('#tutor-cal').fullCalendar('refetchEvents');
      }).fail(function(response) {
        swal({
              title: "Oops...",
              text: response.responseJSON.errors,
              confirmButtonColor: "#EF5350",
              type: "error"
          });
      });
  })

})

var createDate = function() {
  var date = $('.timepicker').val();
  var time = $('.datepicker').val();
  var dateTime = date + " " + time;
  return (new Date(dateTime));
}

// Timeslot New Button

var makeNewTimeslotbutton = function(){
  $('#modal_new_timeslot').modal({ show: true });
}