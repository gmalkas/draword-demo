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
    @width = @canvas.width
    @height = @canvas.height
    @context = @canvas.getContext('2d')

    @context.fillStyle = 'white'
    @context.fillRect(0, 0, @width, @height)

    @context.beginPath()
    @context.lineTo(10, 10)
    @context.stroke()
    @context.lineWidth = 5

    setInterval(=>
      return unless @updated
      @updated = false
      this.trigger('drawing:updated', @canvas.toDataURL())
    , 500)

  update: (url) ->
    image = new Image()
    image.onload = =>
      @context.drawImage(image, 0, 0)
    image.src = url

  getData: ->
    @canvas.toDataURL()

  disable: ->
    @canDraw = false
    @drawing = false

  enable: ->
    @canDraw = true

  getMousePosition: (event) ->
    {
      x: event.clientX - @canvas.offsetLeft
      y: event.clientY - @canvas.offsetTop
    }

  startDrawing: (event) ->
    @drawing = true if @canDraw
    @startingPosition = this.getMousePosition(event)
    @context.beginPath()
    @context.moveTo(@startingPosition.x, @startingPosition.y)
    false

  draw: (event) ->
    return unless @drawing

    @updated = true

    position = this.getMousePosition(event)
    @context.lineTo(position.x, position. y)
    @context.stroke()

  stopDrawing:->
    @drawing = false
