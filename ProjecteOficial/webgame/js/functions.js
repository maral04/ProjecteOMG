// remap jQuery to $
(function($){})(window.jQuery);

$(document).ready(function (){

/*-----------------------------------------------------------------------------------*/
/*  FOOTER COPYRIGHT YEAR
/*-----------------------------------------------------------------------------------*/
    var currentYear = (new Date).getFullYear();
    $('span.date').text(currentYear);

/*-----------------------------------------------------------------------------------*/
/*  FRONTPAGE IMAGE OVERLAYS
/*-----------------------------------------------------------------------------------*/
    $('.bar').mosaic({
      animation : 'slide'
    });

/*-----------------------------------------------------------------------------------*/
/*  GET TWEETS
/*-----------------------------------------------------------------------------------*/
  $(".tweet").tweet({
    username: "maral04", //change this to your twitter username
    join_text: "auto",
    avatar_size: 0, //show avatar?
    count: 1,       //number of tweets to display
    auto_join_text_default: "",
    auto_join_text_ed: "",
    auto_join_text_ing: "",
    auto_join_text_reply: "",
    auto_join_text_url: "",
    loading_text: "loading tweets..." //you can change this to a preloader image
  });

/*-----------------------------------------------------------------------------------*/
/*  INPUT WATERMARKS (PLACEHOLDERS)
/*-----------------------------------------------------------------------------------*/
  $('.jq_watermark').watermark();

/*-----------------------------------------------------------------------------------*/
/*  CONTACT FORM
/*-----------------------------------------------------------------------------------*/
  $("#ajax-contact-form").submit(function() {
    var str = $(this).serialize();

    $.ajax({
      type: "POST",
      url: "includes/contact-process.php",
      data: str,
      success: function(msg) {
          // Message Sent? Show the 'Thank You' message
          if(msg == 'OK') {
            result = '<div class="notification_ok">Your message has been sent. Thank you!</div>';
            //$("#fields").hide();
          } else {
            result = msg;
          }
          $('#note').html(result);
      }
    });
    return false;
  });

/*-----------------------------------------------------------------------------------*/
/*  HOMEPAGE SLIDER - thanks to user Samich: http://jsfiddle.net/GPuh6/23/light/
/*-----------------------------------------------------------------------------------*/

$('.slider .slide:first').addClass('active').fadeIn(400);

function rotate(index) {
  $('.slider .slide.active').removeClass('active').fadeOut(300, function() {
    $('.slider .slide:eq(' + index + ')').addClass('active').fadeIn(400);
  });   
}

$('.slider-nav li a').click(function() {    
  var index = $(this).parent().index('li');
  rotate(index);
  return false;
});

setInterval(function() {
    var $next = $('.slider .slide.active').next();

    if ($next.length == 0)
        $next = $('.slider .slide:first');

    rotate($next.index());
}, 8500); //Control the timing in mseconds


});