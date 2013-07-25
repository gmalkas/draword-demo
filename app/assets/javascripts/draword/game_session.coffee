class Draword.GameSession
  constructor: (game, dispatcher) ->
    _.extend @, Backbone.Events
    @game = game
    @dispatcher = dispatcher

    this.setup()

  setup: ->
    @chat = @dispatcher.subscribe(@game.getChatChannel())
    @chat.bind 'new', (message) =>
      this.trigger('chat:message', message)

  sendChatMessage: (content) ->
    message =
      'username': App.currentUser.getUsername()
      'content': content
    
    @chat.trigger('new', message)
