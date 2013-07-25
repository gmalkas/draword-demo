class Draword.Views.Guess extends Backbone.View
  tagName: 'tr'

  initialize: (options) ->
    super()
    @username = options.username
    @word = options.word
    @correct = options.correct

  templateContext: ->
    {
      username: @username
      word: @word
      correct: @correct
    }

  render: ->
    this.$el.html(HandlebarsTemplates['guess'](this.templateContext()))

