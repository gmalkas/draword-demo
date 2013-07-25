class Draword.Views.Player extends Backbone.View

  tagName: 'tr'

  initialize: (options) ->
    super(options)
    @player = options.player

  templateContext: ->
    {
      id: @player.id
      name: @player.name
    }

  render: ->
    this.$el.html(HandlebarsTemplates['player'](this.templateContext()))
