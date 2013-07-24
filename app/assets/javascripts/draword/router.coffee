class Draword.Router extends Backbone.Router
  routes:
    '': 'home'
    'game/:id': 'joinGame'

  home: ->
    console.log 'Welcome!'
    view = new Draword.Views.Home()
    $('#main').html(view.el)
    view.render()

  joinGame: (id) ->
    console.log "You want to see #{id}"
