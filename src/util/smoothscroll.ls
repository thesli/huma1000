export SmoothScroll = (el, duration = 500, cb = ->, context, end) ->
  curve = -> &0
  position = (start, end, elapsed, duration) ->
    return end if elapsed > duration
    return start + (end - start) * curve(elapsed / duration)

  start = context.scrollTop
  clock = Date.now!
  # end = end || el.getBoundingClientRect().top + context.scrollTop - offset;
  end = end || el.offsetTop
  requestAnimationFrame = window.requestAnimationFrame
    or window.mozRequestAnimationFrame
    or window.webkitRequestAnimationFrame
    or (fn) -> setTimeout(fn, 15)

  do step = ->
    elapsed = Date.now! - clock
    context.scrollTop = position(start, end, elapsed, duration)
    if elapsed > duration
      return
    else
      requestAnimationFrame(step)
