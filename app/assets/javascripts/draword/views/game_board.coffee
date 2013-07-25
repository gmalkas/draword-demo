class Draword.Views.GameBoard extends Backbone.View

  events:
    'keypress #username': 'handleUsernameKeypress'
    'keypress #send-chat': 'handleChatMessageKeypress'
    'keypress #send-guess': 'handleGuessKeypress'

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
    this.addPlayerList()
    this.addCanvas()

  addPlayerList: ->
    @playerListView = new Draword.Views.PlayerList()
    this.$('#leaderboard').append(@playerListView.el)
    @playerListView.render()

  addCanvas: ->
    @drawing = new Draword.Views.DrawingCanvas()
    @drawing.on('drawing:updated', this.sendDrawing, this)
    this.$('#drawing').append(@drawing.el)
    @drawing.render()

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

    @gameSession.on 'player:joined', (player) =>
      @playerListView.addPlayer(player)

    @gameSession.on 'player:left', (player) =>
      @playerListView.removePlayer(player)

    @gameSession.on 'guess:new', (guess) =>
      view = new Draword.Views.Guess(guess)
      this.getGuessList().append(view.el)
      view.render()

    @gameSession.on 'game:over', (state) =>
      this.showGameOver(state.winner)

    _.each @gameSession.getPlayers(), (player) =>
      @playerListView.addPlayer(player)

    @gameSession.on 'drawing:update', (drawing) =>
      this.updateDrawing(drawing)

    @drawing.update(@gameSession.getDrawing()) if @gameSession.hasDrawing()

    @drawing.enable() if @gameSession.isDrawer()
    this.showPlayerRole()

  showPlayerRole: ->
    context =
      isDrawer: @gameSession.isDrawer()
      word: @gameSession.getWordToDraw()
      drawer: @gameSession.getDrawer().name

    this.$('.role').html(HandlebarsTemplates['drawer'](context))

  showGameOver: (winner) =>
    alert(winner + ' has won!')
    window.location = '/'


  sendDrawing: (data) ->
    @gameSession.updateDrawing(data)

  updateDrawing: (drawing) ->
    @drawing.update(drawing.url)

  getChatList: ->
    this.$('#messages')

  getGuessList: ->
    this.$('#guesses-table')

  handleChatMessageKeypress: (event) ->
    return unless event.keyCode == 13

    event.preventDefault()
    message = this.$('#send-chat').val()

    return if message == ''

    @gameSession.sendChatMessage(message)
    this.$('#send-chat').val('')

  handleGuessKeypress: (event) ->
    return unless event.keyCode == 13

    event.preventDefault()
    guess = this.$('#send-guess').val()

    return if guess == ''

    @gameSession.sendGuess(guess)
    this.$('#send-guess').val('')
