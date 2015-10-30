(function() {
  'use strict';

  angular
    .module('mentorMe')
    .run(runBlock);

  /** @ngInject */
  function runBlock($log) {

    $log.debug('runBlock end');
  }

})();
