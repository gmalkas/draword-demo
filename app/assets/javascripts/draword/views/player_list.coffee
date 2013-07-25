class Draword.Views.PlayerList extends Backbone.View

  tagName: 'table'
  id: 'players'

  addPlayer: (player) ->
    view = new Draword.Views.Player({ player: player })
    view.$el.attr('data-player-id', player.id)
    this.$el.append(view.el)
    view.render()

  removePlayer: (player) ->
    view = this.$('tr[data-player-id="' + player.id + '"]')
    view.fadeOut 350, ->
      view.remove()
