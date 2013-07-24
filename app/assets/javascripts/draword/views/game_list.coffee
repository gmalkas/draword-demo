class Draword.Views.GameList extends Backbone.View

  initialize: (options) ->
    @collection = options.collection
    @collection.on('reset add remove sync', this.render, this)

  render: ->

