// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// $(document).ready(function(){

//   $("#sign-up-btn").click(function(event) {
//     event.preventDefault();
//     var url = $(this).attr("data-timeslot-url")
//     $("#modal_remote").modal('hide');
//     $.ajax({
//       type: "PATCH",
//       url: url
//     }).done(function(){
//         swal({
//               title: "Good job!",
//               text: "You clicked the button!",
//               confirmButtonColor: "#66BB6A",
//               type: "success"
//           });
//     }).fail(function() {
//       swal({
//             title: "Oops...",
//             text: "Something went wrong!",
//             confirmButtonColor: "#EF5350",
//             type: "error"
//         });
//     });
//   });

// })

var studentSignUp = function(timeslot_id){
  $("#modal_remote").modal('hide');
  // $.ajax({
  //     type: "PATCH",
  //     url: url
  //   }).done(function(){
  //       swal({
  //             title: "Good job!",
  //             text: "You clicked the button!",
  //             confirmButtonColor: "#66BB6A",
  //             type: "success"
  //         });
  //   }).fail(function() {
  //     swal({
  //           title: "Oops...",
  //           text: "Something went wrong!",
  //           confirmButtonColor: "#EF5350",
  //           type: "error"
  //       });
  //   });
}