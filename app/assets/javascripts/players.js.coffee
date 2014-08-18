# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  if $(".players.index").length > 0
    console.log "HELLO, players index"
    es = new EventSource('stream')
    console.log "Url:" + es.url #=> Url:http://localhost:3000/games/3/stream
    format_player = (player_json_string) ->
      "<tr><td>#{JSON.parse(player_json_string).nick}</td><td>SHOW</td><td>EDIT</td><td>DESTROY</td> </tr>"


    es.onmessage= (e) ->
      console.log "MESSAGE"
      console.log "data:",  e.data
      console.log "event:", e.event
      console.log "id:", e.id

    es.onopen = (e) ->
      console.log "event source OPEN"
      console.log ">" + e
      for p of e
        console.log "e[#{p}]="+ e[p]

    es.addEventListener 'player-joined', (e) ->
      console.log "PLAYER JOINED"
      console.log "data:",  e.data
      console.log "event:", e.event
      console.log "id:", e.id
      $('#current-players').append format_player(e.data)


    example='{"nick":"d\'Artagnan","created_at":"2014-08-18T15:46:16.786+04:00"}'

    $('#current-players').append format_player(example)