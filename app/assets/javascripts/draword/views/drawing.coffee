class Draword.Views.DrawingCanvas extends Backbone.View

  events:
    'mousedown': 'startDrawing'
    'mousemove': 'draw'
    'mouseup': 'stopDrawing'
    'mouseout': 'stopDrawing'

  initialize: (options) ->
    super(options)
    this.disable()

  render: ->
    this.$el.html(HandlebarsTemplates['drawing_canvas']())
    @canvas = this.$('canvas')[0]
    @context = @canvas.getContext('2d')

    @context.beginPath()
    @context.lineTo(10, 10)
    @context.stroke()
    @context.lineWidth = 5

  update: (url) ->
    @context.drawImage(url, 0, 0)

  getData: ->
    @canvas.toDataURL()

  disable: ->
    @canDraw = false
    @drawing = false

  enable: ->
    @canDraw = true

  startDrawing: ->
    console.log 'start'
    @drawing = true if @canDraw

  draw: ->
    console.log 'draw' if @drawing

  stopDrawing: ->
    console.log 'stop'
    @drawing = false
