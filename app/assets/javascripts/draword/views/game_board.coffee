class Draword.Views.GameBoard extends Backbone.View

  events:
    'keypress #username': 'handleUsernameKeypress'
    'keypress #send-chat': 'handleChatMessageKeypress'

  initialize: (options) ->
    super(options)
    @game = options.model
    this.setup()
    this.showUsernamePrompt()

  setup: ->
    @game.on('sync', this.render, this)
    App.currentUser.on('joined', this.join, this)

  templateContext: ->
    {
      title: @game.get('title')
    }

  render: ->
    this.$el.html(HandlebarsTemplates['game_board'](this.templateContext()))

  showUsernamePrompt: ->
    this.$('#choose-username').show()
    this.$('#game').css('opacity', '.2')

  hideUsernamePrompt: ->
    this.$('#choose-username').hide()
    this.$('#game').css('opacity', '1')

  handleUsernameKeypress: (event) ->
    return unless event.keyCode == 13

    event.preventDefault()
    username = this.$('#username').val()

    if username == ''
      alert('Please enter a username!')
      return
    else
      App.currentUser.join(username, @game)

  join: (gameSession) ->
    this.hideUsernamePrompt()

    @gameSession = gameSession
    @gameSession.on 'chat:message', (message) =>
      view = new Draword.Views.ChatMessage(message)
      this.getChatList().append(view.el)
      view.render()

  getChatList: ->
    this.$('#messages')

  handleChatMessageKeypress: (event) ->
    return unless event.keyCode == 13

    event.preventDefault()
    message = this.$('#send-chat').val()

    return if message == ''

    @gameSession.sendChatMessage(message)
    this.$('#send-chat').val('')
