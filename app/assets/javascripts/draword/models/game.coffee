class Draword.Models.Game extends Backbone.Model
  getChatChannel: ->
    "game-#{this.id}"
