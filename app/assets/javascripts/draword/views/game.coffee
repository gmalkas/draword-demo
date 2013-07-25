class Draword.Views.Game extends Backbone.View

  tagName: 'tr'

  events:
    'click .join-game': 'joinGame'

  initialize: (options) ->
    super(options)
    @game = options.model

  templateContext: ->
    {
      title: @game.get('title')
    }

  render: ->
    this.$el.html(HandlebarsTemplates['game'](this.templateContext()))
  
  joinGame: (event) ->
    event.preventDefault()
    Draword.View.navigateTo(new Draword.Views.GameBoard({ model: @game }))
