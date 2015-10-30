'use strict';

angular.module('myApp.view2', ['ngRoute', 'ngResource'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/view2', {
    templateUrl: 'view2/view2.html',
    controller: 'View2Ctrl'
  });
}])


.controller('View2Ctrl', function($scope, $http) {
   var doShit = function() {
    $http({
          method: 'GET',
          url: 'api/hello'
      }).
      success(function(data, status, headers, config) {
          $scope.items = data;
      }); 
  }
  doShit();
})
