class Draword.Views.ChatMessage extends Backbone.View
  tagName: 'tr'

  initialize: (options) ->
    super()
    @username = options.username
    @message = options.content

  templateContext: ->
    {
      username: @username
      message: @message
    }

  render: ->
    this.$el.html(HandlebarsTemplates['chat_message'](this.templateContext()))
