var cancelAppointment = function(timeslot_id) {
  $("#modal_remote").modal('hide');
  swal({
        title: "Are you sure?",
        text: "You will be removed from this appointment.",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#EF5350",
        confirmButtonText: "Yes, cancel my appointment.",
        cancelButtonText: "No, I don't want to cancel.",
        closeOnConfirm: false,
        closeOnCancel: true
    },
  function(isConfirm){
    if (isConfirm) {
      $.ajax({
          type: "PATCH",
          url: "/api/timeslots/" + timeslot_id + "/cancel",
          beforeSend: customBlockUi(this)
        }).done(function(){
            swal({
                title: "Cancelled",
                text: "Your mentoring appointment has been cancelled.",
                confirmButtonColor: "#FFFFFF",
                showConfirmButton: false,
                allowOutsideClick: true,
                timer: 1500,
                type: "info"
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
  });
}

