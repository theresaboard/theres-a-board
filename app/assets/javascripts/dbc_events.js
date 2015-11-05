$(document).ready(function() {
  var calRequest = $.ajax('https://www.googleapis.com/calendar/v3/calendars/devbootcamp.com_ium1vgtodjeckf102tn0hg4nas%40group.calendar.google.com/events?singleEvents=true&timeMax=2015-12-05T00%3A00%3A00Z&timeMin=2015-11-05T00%3A00%3A00Z&key=AIzaSyA0cLu04x--R5RZVdsMpFwUs24X6N7X3ig')
  calRequest.done(function(gCal) {
    var dbcEvents = {};
    gCal.items.forEach(function(event) {
      var start    = new Date(event.start.dateTime)
      var date     = start.toDateString();
      var hours    = start.getHours();
      var minutes  = start.getMinutes();
      var meridian = 'am';
      if (hours > 12) { hours -= 12; meridian = 'pm'; }
      var time = hours.toString() + ':' + minutes.toString() + meridian;
      var summary   = event.summary;
      if (dbcEvents[date] === undefined) { dbcEvents[date] = []; }
      dbcEvents[date].push(time + " - " + summary);
    });
    var dbcEventData = {};
    Object.keys(dbcEvents).sort(function(a,b) {
      return new Date(a) - new Date(b);
    }).forEach(function(eventDate) {
      dbcEventData[eventDate] = dbcEvents[eventDate];
    });
    // Do something with dbcEventData.  It looks like this (in chron order):
    // { "Tue Nov 10 2015": ["7:0pm - NYC.rb Talks"],
    //   "Tue Nov 24 2015": ["7:0pm - NYC.rb Hackfest",
    //                       "7:0pm - Learn Python NYC Meetup at DBC"],
    //   etcetera . . .
    // }
  });
});
