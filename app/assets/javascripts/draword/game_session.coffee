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

  sendChatMessage: (content) ->
    message =
      'username': App.currentUser.getUsername()
      'content': content
    
    @channel.trigger('chat:message', message)
