class Draword.App
  constructor: ->
    @currentUser = new Draword.User()
    new Draword.Router()
    Backbone.history.start
      pushState: true
