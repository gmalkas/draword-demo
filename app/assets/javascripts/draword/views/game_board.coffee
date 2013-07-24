class Draword.Views.GameBoard extends Backbone.View

  events:
    'keypress #username': 'handleUsernameKeypress'

  initialize: (options) ->
    super(options)
    @game = options.model
    this.setup()
    this.showUsernamePrompt()

  setup: ->
    @game.on('sync', this.render, this)

  templateContext: ->
    {
      title: @game.get('title')
    }

  render: ->
    this.$el.html(HandlebarsTemplates['game_board'](this.templateContext()))

  showUsernamePrompt: ->
    this.$('#prompt').show()
    Draword.View.disable()

  hideUsernamePrompt: ->
    this.$('#prompt').hide()
    Draword.View.enable()

  handleUsernameKeypress: (event) ->
    return unless event.keyCode == 13

    event.preventDefault()
    username = this.$('#username').val()

    if username == ''
      alert('Please enter a username!')
      return
    else
      @gameSession = App.currentUser.join(username, @game)
      @gameSession.on('joined', this.join, this)

  join: ->
    this.hideUsernamePrompt()
