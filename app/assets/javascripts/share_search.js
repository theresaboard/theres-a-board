$(function(){
  $('shares_search_form').submit(function(){
    $.ajax({
      url: '/shares/search',
      type: 'get',
      data: $(this).serialize()
    }).done(function(){
      //append json
    });
  });
});
