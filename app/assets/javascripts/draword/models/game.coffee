class Draword.Models.Game extends Backbone.Model
  getChannel: ->
    "game-#{this.id}"
