class Draword.Views.Home extends Backbone.View
  events:
    'keypress #create-game': 'createGame'

  initialize: ->
    @games = new Draword.Collections.Games()
    @games.fetch()

  render: ->
    this.$el.html(HandlebarsTemplates['home']())
    gameList = new Draword.Views.GameList({ collection: @games })
    this.$el.append(gameList.el)
    gameList.render()
    this

  createGame: (event) =>
    return unless event.keyCode == 13

    event.preventDefault()
    title = this.$('#create-game').val()
    console.log "Creating game #{title}..."
    this.$('#create-game').val('')
    @games.create
      title: title
