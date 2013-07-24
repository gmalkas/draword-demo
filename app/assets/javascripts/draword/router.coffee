class Draword.Router extends Backbone.Router
  routes:
    '': 'home'
    'game/:id': 'joinGame'

  home: ->
    console.log 'Welcome!'
    Draword.View.navigateTo(new Draword.Views.Home())

  joinGame: (id) ->
    console.log "You want to see #{id}"
