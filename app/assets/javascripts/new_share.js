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
    debugger;
    $.ajax({
        type: "POST",
        url: "/shares",
        data: data,
        beforeSend: customBlockUi(this)
      }).done(function(response) {
          swal({
                title: "Awesome!",
                text: "Thanks for your share!",
                confirmButtonColor: "#66BB6A",
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
