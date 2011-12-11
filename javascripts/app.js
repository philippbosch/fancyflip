(function() {
  $(document).bind('touchmove', function(e) {
    e.preventDefault();
    return false;
  });
  $(function() {
    return $('.flippable').on('webkitAnimationStart webkitAnimationEnd', function(e) {
      return $(this).toggleClass('animated', e.type.substr(-5).toLowerCase() === 'start');
    }).on('click', function(e) {
      var $el;
      $el = $(this);
      if ($el.is('.animated')) {
        return false;
      }
      if ($el.is('.flip-forward')) {
        $el.removeClass('flip-forward');
        return $el.addClass('flip-backward');
      } else {
        $el.removeClass('flip-backward');
        return $el.addClass('flip-forward');
      }
    });
  });
}).call(this);
