$(document).ready(function() {
  var calRequest = $.ajax('https://www.googleapis.com/calendar/v3/calendars/devbootcamp.com_ium1vgtodjeckf102tn0hg4nas%40group.calendar.google.com/events?singleEvents=true&timeMax=2015-12-05T00%3A00%3A00Z&timeMin=2015-11-05T00%3A00%3A00Z&key=AIzaSyA0cLu04x--R5RZVdsMpFwUs24X6N7X3ig')
  calRequest.done(function(gCal) {
    var dbcEventList = [];
    gCal.items.forEach(function(event) {
      var start    = new Date(event.start.dateTime)
      var summary   = event.summary;
      dbcEventList.push([start, summary]);
    });
    dbcEventList.sort(function(a,b) { return a[0] - b[0]; });
    var dbcEventData = {};
    dbcEventList.forEach(function(event) {
      var date     = event[0].toDateString();
      var hours    = event[0].getHours();
      var minutes  = event[0].getMinutes().toString();
      var meridian = 'am';
      if (hours > 12) { hours -= 12; meridian = 'pm'; }
      if (minutes.length == 1) { minutes = '0' + minutes }
      var time = hours + ':' + minutes + meridian;
      if (dbcEventData[date] === undefined) { dbcEventData[date] = []; }
      dbcEventData[date].push(time + " - " + event[1]);
    });
    // Do something with dbcEventData.  It looks like this (in chron order):
    // { "Tue Nov 10 2015": ["7:0pm - NYC.rb Talks"],
    //   "Tue Nov 24 2015": ["7:0pm - NYC.rb Hackfest",
    //                       "7:0pm - Learn Python NYC Meetup at DBC"],
    //   etcetera . . .
    // }
  });
});
