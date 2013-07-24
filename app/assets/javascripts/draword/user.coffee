class Draword.User
  constructor: ->
    this.connect()

  connect: ->
    @dispatcher = new WebSocketRails('localhost:3000/websocket')
    @dispatcher.on_open = =>
      console.log "Annnnnnnnd we're on!"

  isPlaying: =>

  currentGame: =>

  join: (game) =>

  quit: =>

