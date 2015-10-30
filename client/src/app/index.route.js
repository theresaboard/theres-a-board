(function() {
  'use strict';

  angular
    .module('mentorMe')
    .config(routerConfig);

  /** @ngInject */
  function routerConfig($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainController',
        controllerAs: 'main'
      })
      .state('timeslots', {
        url: '/timeslots',
        templateUrl: 'app/timeslots/timeslots.html',
        controller: 'TimeslotsController',
        controllerAs: 'timeslots'
      });

    $urlRouterProvider.otherwise('/');
  }

})();
