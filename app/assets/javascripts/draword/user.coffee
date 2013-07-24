class Draword.User extends Backbone.Events
  constructor: ->
    this.connect()

  connect: ->
    @dispatcher = new WebSocketRails('localhost:3000/websocket')
    @dispatcher.on_open = =>
      console.log "Annnnnnnnd we're on!"

  isPlaying: =>

  currentGameSession: =>

  join: (game) =>
    new Draword.GameSession(game, @dispatcher)

  quit: =>

