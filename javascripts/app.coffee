$(document).bind 'touchmove', (e) ->
    e.preventDefault()
    return false

$.fn.transition = (properties, duration=400, ease, callback) ->
    depth = parseInt($(this).data('transition-depth') || 0, 10) + 1
    $el = $(this)
    
    $el.data 'transition-depth', depth
    
    transitionCallback = () ->
        if properties == "__sleep__"
            window.setTimeout () ->
                $el.trigger "transitionend-#{depth}"
            , duration
        else
            $el.animate properties, duration, ease, () ->
                $el.trigger "transitionend-#{depth}"
    
    if depth == 1
        transitionCallback()
    else
        $el.bind "transitionend-#{depth-1}", transitionCallback

$.fn.transitionSleep = (duration=1000) ->
    $(this).transition '__sleep__', duration

$ ->
    $('.flippable').on 'webkitAnimationStart webkitAnimationEnd', (e) ->
        $(this).toggleClass 'animated', e.type.substr(-5).toLowerCase() == 'start'
    .on 'click', (e) ->
        $el = $(this)
        if $el.is('.animated')
            return false
        $el.transition scale: 0.75, 500
        $el.transition scale: 0.75, rotateY: '180deg', 1000
        $el.transition scale: 1, rotateY: '180deg', 500
        $el.transitionSleep()
        $el.transition scale: 0.75, rotateY: '180deg', 500
        $el.transition scale: 0.75, 1000
        $el.transition scale: 1, 500
        
        # if $el.is('.flip-forward')
        #     $el.removeClass('flip-forward')
        #     $el.addClass('flip-backward')
        # else
        #     $el.removeClass('flip-backward')
        #     $el.addClass('flip-forward')
