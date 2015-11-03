var deleteOpenSession = function(timeslot_id){
  event.preventDefault();
  $("#modal_remote").modal('hide');
  swal({
      title: "Are you sure you wish to cancel?",
      text: "This will delete your mentoring timeslot.",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#EF5350",
      confirmButtonText: "Yes, cancel this mentoring timeslot.",
      cancelButtonText: "No, I've changed my mind.",
      closeOnConfirm: false,
      closeOnCancel: false
  },
  function(isConfirm){
    if (isConfirm) {
      $.ajax({
          type: "DELETE",
          url: "/api/timeslots/" + timeslot_id
        }).done(function(){
            swal({
                title: "Deleted!",
                text: "Your mentoring availabilty has been removed.",
                confirmButtonColor: "#66BB6A",
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
    else {
      swal({
        title: "Cancelled",
        text: "Your availabilty is still scheduled.",
        confirmButtonColor: "#2196F3",
        type: "error"
      });
    }
  });
}
