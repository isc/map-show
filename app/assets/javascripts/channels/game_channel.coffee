App.gameChannel = App.cable.subscriptions.create { channel: 'GameChannel' },
  received: (data) ->
    component = window.playerVue || window.tvVue
    return unless component
    component.players.push data.player if data.event is 'new_player'
    component.gameStarted() if data.event is 'game_start'
    component.play() if data.event is 'play' and component.play
    component.updateState(data) if data.event is 'state' and component.updateState
