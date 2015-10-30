(function() {
  'use strict';

  angular
    .module('mentorMe')
    .factory('Timeslot', ['railsResourceFactory', function (railsResourceFactory) {
      return railsResourceFactory({
        url: '/api/timeslots',
        name: 'timeslot'
      });
    }])
    .controller('TimeslotsController', TimeslotsController);

      /** @ngInject */
      function TimeslotsController($timeout, webDevTec, Timeslot) {
        var vm = this;

        Timeslot.query().then(function (results) {
            vm.slots = results
        });
      }
})();
