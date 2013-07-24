class Draword.Views.Game extends Backbone.View

  tagName: 'li'

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
    this.$el.html(HandlebarsTemplates['game'](@templateContext()))
  
  joinGame: (event) ->
    event.preventDefault()
    console.log "You want to join game #{@game.id}"
