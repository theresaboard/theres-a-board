$(function(){
  $('#update_user_settings').click(function(event){
    event.preventDefault();
    var url = event.target.href
    $('#edit_user_modal').modal({
      remote: url,
      show: true
    });
  });

  $('#edit_user_modal').submit('#edit-user-form', function(event){
    event.preventDefault();
    var url = event.target.action;
    var data = $(event.target).serialize();

    if (data.search("text_notify") < 0) {
      data += '&text_notify=false&cellphone=null';
    }
    else if (data.search("email_notify") < 0){
      data += '&email_notify=false';
    }

    $.ajax({
      type: "PATCH",
      url: url,
      data: data,
      beforeSend: customBlockUi(this)
    }).done(function(response){
      $('#edit_user_modal').modal('toggle');
      swal({
          title: "Great!",
          text: "Your settings have been updated.",
          confirmButtonColor: "#FFFFFF",
          showConfirmButton: false,
          allowOutsideClick: true,
          timer: 1500,
          type: "success"
      });
    }).fail(function(response){
      swal({
          title: "Oops...",
          text: response.responseJSON.errors,
          confirmButtonColor: "#EF5350",
          type: "error"
      });
    });
  });
});
