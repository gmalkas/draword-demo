class Draword.Views.GameBoard extends Backbone.View

  initialize: (options) ->
    super(options)
    @game = options.model
    this.setup()

  setup: ->
    @game.on('sync', this.render, this)

  templateContext: ->
    {
      title: @game.get('title')
    }

  render: ->
    this.$el.html(HandlebarsTemplates['game_board'](this.templateContext()))
