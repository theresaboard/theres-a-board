(function() {
  'use strict';

  angular
    .module('mentorMe')
    .controller('TimeslotsController', TimeslotsController);

  /** @ngInject */
  function TimeslotsController($timeout, webDevTec) {
    var vm = this;

    vm.team = ["Jeder", "Smokecode","DCR8898","Dtisdall"];
  }
})();
