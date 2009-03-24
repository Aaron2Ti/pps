$(function(){
  $('.head .account a').toggle(
    function(){$('.head .account').animate({height: '180px'})},
    function(){$('.head .account').animate({height: '32px'})}
  );
  //+++++++++++++Animate border color+++++++++++++++
  var bd_c = '#3a3a2f';        // border's color
  var bd_h_c = '#ffb57d';      // border's color on mouse hover

  $('.hot-tags').hover(
    function(){
      $(this).animate({ borderColor: bd_h_c });
    },
    function(){
      $(this).animate({ borderColor: bd_c });
    }
  );

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

  $('.menu > li').hover(
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

//++++++++++++++Add Lightbox++++++++++++++++++++++
  $('div.paper > p').click(
    function(){
      $(this).next('a.lightbox').trigger('click');
    }
  );
  $('.lightbox').lightbox();

//++++++++Toggle User Form Fields++++++++++++++++++
  $('#new_user > a, #edit_user > a').click(function(){
    $(this).next('fieldset').toggle('slow');
  });
})
