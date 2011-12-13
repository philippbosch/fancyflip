(function() {
  $(document).bind('touchmove', function(e) {
    e.preventDefault();
    return false;
  });
  $.fn.transition = function(properties, duration, ease, callback) {
    var $el, depth, transitionCallback;
    if (duration == null) {
      duration = 400;
    }
    depth = parseInt($(this).data('transition-depth') || 0, 10) + 1;
    $el = $(this);
    $el.data('transition-depth', depth);
    transitionCallback = function() {
      if (properties === "__sleep__") {
        return window.setTimeout(function() {
          return $el.trigger("transitionend-" + depth);
        }, duration);
      } else {
        return $el.animate(properties, duration, ease, function() {
          return $el.trigger("transitionend-" + depth);
        });
      }
    };
    if (depth === 1) {
      return transitionCallback();
    } else {
      return $el.bind("transitionend-" + (depth - 1), transitionCallback);
    }
  };
  $.fn.transitionSleep = function(duration) {
    if (duration == null) {
      duration = 1000;
    }
    return $(this).transition('__sleep__', duration);
  };
  $(function() {
    return $('.flippable').on('webkitAnimationStart webkitAnimationEnd', function(e) {
      return $(this).toggleClass('animated', e.type.substr(-5).toLowerCase() === 'start');
    }).on('click', function(e) {
      var $el;
      $el = $(this);
      if ($el.is('.animated')) {
        return false;
      }
      $el.transition({
        scale: 0.75
      }, 500);
      $el.transition({
        scale: 0.75,
        rotateY: '180deg'
      }, 1000);
      $el.transition({
        scale: 1,
        rotateY: '180deg'
      }, 500);
      $el.transitionSleep();
      $el.transition({
        scale: 0.75,
        rotateY: '180deg'
      }, 500);
      $el.transition({
        scale: 0.75
      }, 1000);
      return $el.transition({
        scale: 1
      }, 500);
    });
  });
}).call(this);
