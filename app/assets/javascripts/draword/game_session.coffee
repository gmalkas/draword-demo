class Draword.GameSession
  constructor: (game, dispatcher) ->
    _.extend @, Backbone.Events
    @game = game
    @dispatcher = dispatcher

    this.setup()

  setup: ->
    @channel = @dispatcher.subscribe(@game.getChannel())
    @channel.bind 'chat:message', (message) =>
      this.trigger('chat:message', message)

    @channel.bind 'player:joined', (player) =>
      this.trigger('player:joined', player)

    @channel.bind 'player:left', (player) =>
      this.trigger('player:left', player)

    @dispatcher.bind 'guess:new', (guess) =>
      return unless guess.game_id == @game.id
      this.trigger('guess:new' , guess)

    @dispatcher.bind 'game:over', (state) =>
      return unless state.game_id == @game.id
      this.trigger('game:over' , state)

  sendChatMessage: (content) ->
    message =
      'username': App.currentUser.getUsername()
      'content': content

    @channel.trigger('chat:message', message)

  sendGuess: (word) ->
    guess =
      'word': word

    @dispatcher.trigger('game.guess', guess)

  getPlayers: ->
    @game.get('players')

  isDrawer: ->
    this.getDrawer().id == App.currentUser.id

  getDrawer: ->
    @game.get('drawer')

  getWordToDraw: ->
    @game.get('word')
