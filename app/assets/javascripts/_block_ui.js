var customBlockUi = function(that) {
    var block = $(that).parent();
    $(block).block({
      message: '<span class="text-semibold"><i class="icon-spinner4 spinner position-left"></i>&nbsp; Updating data</span>',
      timeout: 2000, //unblock after 2 seconds
        overlayCSS: {
            backgroundColor: '#fff',
            opacity: 0.8,
            cursor: 'wait'
        },
        css: {
            border: 0,
            padding: '10px 15px',
            color: '#fff',
            width: 'auto',
            '-webkit-border-radius': 2,
            '-moz-border-radius': 2,
            backgroundColor: '#333'
        }
    });
};
