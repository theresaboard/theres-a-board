$(function(){
  $('#update_user_settings').click(function(event){
    event.preventDefault();
    var url = event.target.href
    $('#edit_user_modal').modal({
      remote: url,
      show: true
    });
  });
});