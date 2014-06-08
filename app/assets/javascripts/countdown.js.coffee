# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Countdown
  constructor: (@target_id = "#timer", @start_time = "30:00") ->

  init: ->
    @reset()
    if not @start_time
      return
    @sound_html5=$('audio').get(0)
    @sound_html5.play()
    #@sound = new Howl( {urls:['/Beep.ogg']})
    @sound = new Howl( {urls:['/Tick.mp3']})
    window.tick = =>
      @tick()
    window.tick_id=setInterval(window.tick, 1000)

  reset: ->
    time = @start_time.split(':')
    @minutes = parseInt(time[0])
    @seconds = parseInt(time[1])
    @updateTarget()

  stop: ->
    $(@target_id).data("stop", true)
    (new Howl( {urls:['/Beep.ogg']})).play()

  jumpToExit: ->
    window.location.replace($('#stop-timer').attr("href"))


  tick: ->
    if $(@target_id).data("stop")
      clearInterval(window.tick_id)
      @jumpToExit()
      return
    [seconds, minutes] = [@seconds, @minutes]
    if seconds > 0 or minutes > 0
      @sound.play()
      if seconds is 0
        @minutes = minutes - 1
        @seconds = 59
      else
        @seconds = seconds - 1
    else
      clearInterval(window.tick_id)
      (new Howl( {
        urls:['/Zen.mp3'],
        onend: @jumpToExit
                 })).play()
    @updateTarget()

  updateTarget: ->
    seconds = @seconds
    seconds = '0' + seconds if seconds < 10
    $(@target_id).html(@minutes + ":" + seconds)

$('.countdown.show').ready ->
  timer = new Countdown('#timer',  $('#timer').text()  )
  $('#stop-timer').click ->
    timer.stop()
    $('#stop-timer').unbind('click')
    return false
  timer.init()
