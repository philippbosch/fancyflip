$(document).bind 'touchmove', (e) ->
    e.preventDefault()
    return false

$ ->
    $('.flippable').on 'webkitAnimationStart webkitAnimationEnd', (e) ->
        $(this).toggleClass 'animated', e.type.substr(-5).toLowerCase() == 'start'
    .on 'click', (e) ->
        $el = $(this)
        if $el.is('.animated')
            return false
        if $el.is('.flip-forward')
            $el.removeClass('flip-forward')
            $el.addClass('flip-backward')
        else
            $el.removeClass('flip-backward')
            $el.addClass('flip-forward')
    