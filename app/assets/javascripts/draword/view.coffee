class Draword.View
  @navigateTo: (view) ->
    $('body').empty()
    $('body').append(view.el)
    view.render()
