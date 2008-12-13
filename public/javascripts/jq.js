//++++++++++++++++++++++++Paper+++++++++++++++++++
$(function(){
  var bd_c = '#3a3a2f';        // border's color
  var bd_h_c = '#ffb57d'       // border's color on mouse hover
  $('div.paper').hover(
      function(){ 
        $(this).animate({ borderColor: bd_h_c });
        $(this).children('img').animate({ opacity: 1 });
        $(this).children('p').animate({ bottom: 0 });
      },
      function(){
        $(this).animate({ borderColor: bd_c });
        $(this).children('img').animate({ opacity: 0.8 });
        $(this).children('p').animate({ bottom: -40 });
      }
    );
  $('div.menu > a').hover(
      function(){ 
        $(this).animate({
          color: '#aeafed',
          borderLeftColor: bd_h_c,
          paddingLeft: '15px'
        });
      },
      function(){
        $(this).animate({
          color: '#cec5b5',
          borderLeftColor: bd_c,
          paddingLeft: '20px'
        });
      }
    );
})
//++++++++++++++++++++++++Paper+++++++++++++++++++
