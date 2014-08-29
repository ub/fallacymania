jQuery ->
  if $("body.games ul.list-group#current-players").length > 0
    stream_url = $('#current-players').data('stream-path')
    es = new EventSource(stream_url)
    es.addEventListener 'player-joined', (e) ->
      $('#current-players').append format_player(e.data)

    es.addEventListener 'player-left', (e) ->
      player=JSON.parse(e.data)
      candidates = $('#current-players li.list-group-item').has("h4:contains('#{player.nick}')")
      exact = candidates.filter ->
        $(@).find("h4").text() == player.nick
      exact.remove()

    format_player = (player_json_string) ->
      player=JSON.parse(player_json_string)
      date = new Date(player.created_at)
      """
      <li class='list-group-item'>
      <h4 class='list-group-item-heading'>#{player.nick}</h4>
         <p class='list-group-item-text'>
              joined at <em>#{date}</em>
         </p>
      </li>
      """

    window.addEventListener "beforeunload", (e) ->
      if ( es )
        es.close()
        delrequest =
          url: stream_url
          type: 'DELETE'
          async: false
          error: (jqXHR, textStatus, errorThrown) ->
            console.error "AJAX ERROR: #{textStatus} #{JSON.stringify(errorThrown)}"
          success: (data, textStatus, jqXHR) ->
            console.log "Successful AJAX call: #{data}"
        $.ajax delrequest
