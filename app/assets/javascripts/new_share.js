$(function(){
  $('#new_share_link').click(function(e){
    e.preventDefault();
    $('#new_share_modal').modal({
      remote: '/shares/new',
      show: true
    });
  });

  $('#new_share_form').submit(function(e){
    e.preventDefault();
    $('#new_share_modal').modal('toggle');
    $.ajax({
        type: "POST",
        url: "/shares",
        data: $(this).serialize(),
        beforeSend: customBlockUi(this)
      }).done(function(response) {
          swal({
                title: "Awesome!",
                text: "Thanks for your share!",
                confirmButtonColor: "#FFFFFF",
                showConfirmButton: false,
                allowOutsideClick: true,
                timer: 1500,
                type: "success"
            });
      }).fail(function(response) {
        swal({
              title: "Oops...",
              text: "Something went wrong!",
              confirmButtonColor: "#EF5350",
              type: "error"
          });
      });
  });
});
