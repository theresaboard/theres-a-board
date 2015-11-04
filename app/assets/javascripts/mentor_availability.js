var mentorAvailability = function () {
  this.status;
  this.checkStatus();
  this.endpoint = "/api/mentor"
}

mentorAvailability.prototype.checkStatus = function () {
  var self = this;
  $.ajax({
    method: "get",
    url: '/api/mentor'
  }).done( function(response) {
    self.status = response.checkedin;
    self.setButtonState();
  })
}

mentorAvailability.prototype.setButtonState = function () {
  if (this.status === false ) {
    this.buttonOpen();
  } else {
    this.buttonCancel();
  }
}

mentorAvailability.prototype.buttonOpen = function () {
  $('#checkin-button').addClass("bg-success-400")
  $('#checkin-button').removeClass("bg-danger-400")
  $('#checkin-button').html('<i class="icon-user-plus"></i><span>Check In</span>')
  $('#checkin-button').attr('onClick','availabilityDispatcher.checkIn()')
}

mentorAvailability.prototype.buttonCancel = function () {
  $('#checkin-button').addClass("bg-danger-400")
  $('#checkin-button').removeClass("bg-success-400")
  $('#checkin-button').html('<i class="icon-user-minus"></i><span>Check Out</span>')
  $('#checkin-button').attr('onClick','availabilityDispatcher.checkOut()')
}


mentorAvailability.prototype.checkOut = function () {
  var self = this;
  $.ajax({
    method: "PUT",
    data: {},
    url: self.endpoint
  }).done ( self.buttonOpen() )
}

mentorAvailability.prototype.checkIn = function () {
  var self = this;
  $.ajax({
    method: "POST",
    data: {},
    url: self.endpoint
  }).done( self.buttonCancel() )
}

var availabilityDispatcher = new mentorAvailability()



