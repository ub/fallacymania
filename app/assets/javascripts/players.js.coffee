# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  if $(".players.index").length > 0
    console.log "Hello, players index"
    es = new EventSource('stream')
    console.log "Url:" + es.url #=> Url:http://localhost:3000/games/3/stream
