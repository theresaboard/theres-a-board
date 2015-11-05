var activeMentors = function () {
  this.endpoint = "/api/mentor_requests/available";
  this.template;
};

activeMentors.prototype.getMentors = function () {
  var self = this;
  $.ajax({
    method: "get",
    url: self.endpoint
  }).done( function(response) {
    self.updateView(response)
  });
};

activeMentors.prototype.updateView = function (data) {
  if (data.length > 0) {
    var html = this.template(data);
    $('#active-mentor-list').html(html)
  } else {
    $('#active-mentor-list').text("There doesn't appear to be any mentors on duty currently.")
  }
};

activeMentors.prototype.setup = function () {
  this.template = Handlebars.compile($("#mentor-template").html());
  this.getMentors();
  this.poll();
};

activeMentors.prototype.poll = function () {
  var self = this
  setTimeout(function(){
    self.getMentors();
    self.poll();
  }, 120000);
};

var mentorList = new activeMentors()

$(document).ready(function() {
  if ( $('#active-mentor-list').length == 1 ) {
    mentorList.setup();
  }
});
