class Draword.Views.GameList extends Backbone.View

  tagName: 'table'
  id: 'games'

  initialize: (options) ->
    super(options)
    @games = options.collection
    @games.on('reset add remove sync', this.render, this)

  render: ->
    this.$el.empty()

    @games.each (game) =>
      view = new Draword.Views.Game({ model: game })
      this.$el.append(view.el)
      view.render()
    this
