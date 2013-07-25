class Draword.User
  constructor: ->
    _.extend @, Backbone.Events
    this.connect()

  connect: ->
    @dispatcher = new WebSocketRails('localhost:3000/websocket')
    @dispatcher.on_open = =>
      console.log "Annnnnnnnd we're on!"

  currentGameSession: ->
    !!this.getCurrentGameSession()

  getCurrentGameSession: ->
    @currentGameSession

  join: (username, game) =>
    @username = username

    @dispatcher.trigger('game.join', { game_id: game.id, username: @username }, (state) =>
      _.extend game.attributes, state
      console.log game
      this.startGameSession(game)
    )

  startGameSession: (game) ->
    @currentGameSession = new Draword.GameSession(game, @dispatcher)
    this.trigger('joined', @currentGameSession)

  getUsername: ->
    @username
