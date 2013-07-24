class Draword.GameSession extends Backbone.Events
  constructor: (game, dispatcher) ->
    @game = game
    @dispatcher = dispatcher
