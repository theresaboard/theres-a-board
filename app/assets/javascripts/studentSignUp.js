var studentSignUp = function(timeslot_id){
  $("#modal_remote").modal('hide');
  $.ajax({
      type: "PATCH",
      url: "/api/timeslots/" + timeslot_id
    }).done(function(){
        swal({
              title: "Great!",
              text: "You have scheduled a tutoring session!",
              confirmButtonColor: "#66BB6A",
              type: "success"
          });
    }).fail(function() {
      swal({
            title: "Oops...",
            text: "Something went wrong!",
            confirmButtonColor: "#EF5350",
            type: "error"
        });
    });
}