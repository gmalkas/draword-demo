class Draword.View
  @navigateTo: (view) ->
    $('#main').empty()
    $('#main').append(view.el)
    view.render()

  @disable: ->
    $('#main').css('opacity', '.5')

  @enable: ->
    $('#main').css('opacity', '1')
