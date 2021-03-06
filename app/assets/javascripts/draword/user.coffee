class Draword.User
  constructor: ->
    _.extend @, Backbone.Events
    this.connect()

  connect: ->
    @dispatcher = new WebSocketRails('10.12.200.193:3000/websocket')
    @dispatcher.on_open = =>
      console.log "And we're on!"

  currentGameSession: ->
    !!this.getCurrentGameSession()

  getCurrentGameSession: ->
    @currentGameSession

  join: (username, game) =>
    @username = username

    @dispatcher.trigger('game.join', { game_id: game.id, username: @username }, (state) =>
      @id = state.id
      _.extend game.attributes, state.game
      this.startGameSession(game)
    )

  startGameSession: (game) ->
    @currentGameSession = new Draword.GameSession(game, @dispatcher)
    this.trigger('joined', @currentGameSession)

  getUsername: ->
    @username
