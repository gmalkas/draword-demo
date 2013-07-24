class Draword.App
  constructor: ->
    new Draword.Router()
    Backbone.history.start
      pushState: true
