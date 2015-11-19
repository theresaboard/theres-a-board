var studentSignUp = function(timeslot_id){
  var data = {};
  data.subject = $("#subject-input").val();
  $("#modal_remote").modal('hide');
  $.ajax({
      data: data,
      type: "PATCH",
      url: "/api/timeslots/" + timeslot_id,
      beforeSend: customBlockUi(this)
    }).done(function(){
        swal({
              title: "Great!",
              text: "You have scheduled a tutoring session!",
              confirmButtonColor: "#FFFFFF",
              showConfirmButton: false,
              allowOutsideClick: true,
              timer: 1500,
              type: "success"
          });
        $('#tutor-cal').fullCalendar('refetchEvents');
    }).fail(function() {
      swal({
            title: "Oops...",
            text: "Something went wrong!",
            confirmButtonColor: "#EF5350",
            type: "error"
        });
    });
}
