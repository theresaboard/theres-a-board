$(function(){
  $('#new_share_link').click(function(e){
    e.preventDefault();
    $('#new_share_modal').modal({
      remote: '/shares/new',
      show: true
    });
  });

  $('#new_share_modal').submit('#new-share-form', function(e){
    e.preventDefault();
    $('#new_share_modal').modal('toggle');
    var data = $(event.target).serialize();
    $.ajax({
        type: "POST",
        url: "/shares",
        data: data,
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
              text: response.responseJSON.errors,
              confirmButtonColor: "#EF5350",
              type: "error"
          });
      });
  });
});
