var requestQueue = function () {
  this.status;
  this.endpoint = "/api/mentor";
  this.template;
}

requestQueue.prototype.getRequests = function () {
  var self = this;
  $.ajax({
    method: "get",
    url: '/api/mentor/queue'
  }).done( function(response) {
    self.updateView(response);
  });
}

requestQueue.prototype.updateView = function (data) {
  if (data.length > 0) {
    var html = this.template(data);
    $('#request-queue-list').html(html);
  } else {
    $('#request-queue-list').text("There doesn't appear to be any open requests");
  }
}

requestQueue.prototype.setup = function () {
  this.template = Handlebars.compile($("#request-template").html());
  this.getRequests(this);
  this.buildListener();
  this.poll();
}

requestQueue.prototype.buildListener = function () {
  var self = this;
  $('#request-queue-list').on('click', '.close-request', function(e) {
      e.preventDefault(e);
      self.closeRequest(e);
      self.getRequests();
  });
}

requestQueue.prototype.closeRequest = function (e) {
  var url = e.currentTarget.attributes['href'].value;
  $.ajax({
    url: url,
    method: "PUT",
    data: {}
  });
}

requestQueue.prototype.poll = function () {
  var self = this;
  setTimeout(function(){
    self.getRequests();
    self.poll();
  }, 3000);
}

var mentorQueue = new requestQueue()

 $(document).ready(function() {
  if ( $('#request-queue-list').length == 1 ) {
    mentorQueue.setup();
  }
});
