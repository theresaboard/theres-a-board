

// class="btn bg-warning-400 btn-block btn-float btn-float-lg" type="button"><i class="icon-people"></i> <span>Get Help</span>

var mentorRequestDispatcher = function () {
  this.activeRequests;
  this.checkStatus();
}

mentorRequestDispatcher.prototype.checkStatus = function () {
  var self = this;
  $.ajax({
    method: "get",
    url: "/api/mentor_requests"
  }).done( function(response) {
    self.activeRequests = response.open;
    self.setButtonState();
    if (self.activeRequests != 0) {
      self.poll()
    }
  })
}

mentorRequestDispatcher.prototype.setButtonState = function () {
  if (this.activeRequests === 0 ) {
    this.buttonOpen();
  } else {
    this.buttonCancel();
  }
}

mentorRequestDispatcher.prototype.buttonOpen = function () {
  $('#help-button').addClass("bg-warning-400")
  $('#help-button').removeClass("bg-danger-400")
  $('#help-button').html('<i class="icon-people"></i><span>Get Help</span>')
  $('#help-button').attr('onClick','mentorDispatcher.openRequest()')
}

mentorRequestDispatcher.prototype.buttonCancel = function () {
  $('#help-button').addClass("bg-danger-400")
  $('#help-button').removeClass("bg-warning-400")
  $('#help-button').html('<i class="icon-cross"></i><span>Cancel</span>')
  $('#help-button').attr('onClick','mentorDispatcher.cancelRequest()')
}


mentorRequestDispatcher.prototype.cancelRequest = function () {
  var self = this;
  $.ajax({
    method: "PUT",
    data: {},
    url: "/api/mentor_requests"
  }).done ( self.buttonOpen() )
}

mentorRequestDispatcher.prototype.openRequest = function () {
  var self = this;
  $.ajax({
    method: "POST",
    data: {},
    url: "/api/mentor_requests"
  }).done( self.buttonCancel() );
  self.poll()
}

mentorRequestDispatcher.prototype.poll = function () {
 var self = this;
 setTimeout(function() {
    self.checkStatus();
 }, 5500);
}

var mentorDispatcher = new mentorRequestDispatcher();
