// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
Event.observe(window, 'load',
  function(){ 
    $$('.menu li a').each( function(element){
      Event.observe(element, 'click',function(){
        $$('.current')[0].removeClassName('current');
        this.up('li').addClassName('current'); 
      })
    });
  }
);
