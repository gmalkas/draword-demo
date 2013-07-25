class Game < ActiveRecord::Base
  after_initialize :setup
  
  WORDS = %w(sun smile human)

  def setup
    @players = []
    @word = WORDS.sample
    @status = "ingoing"
  end

  def players
    @players
  end

  def add_player(player_id, username)
    player = Struct.new(:id, :name).new(player_id, username)
    players <<  player
    @drawer = player if @drawer.nil?
  end

  def remove_player(player_id)
    players.delete_if { |player| player.id == player_id }
    @drawer = nil if @drawer.id == player_id
    reset if players.empty?
  end

  def update_drawing(data)
    @drawing = data
  end

  def correct_guess?(word)
    @word == word
  end

  def reset
    @drawer = nil
    @drawing = nil
    @word = WORDS.sample
  end

  def drawer
    @drawer
  end

  def channel
    "game-#{id}"
  end

  def as_json(options = {})
    h = super(options)
    h[:players] = players
    h[:status] = @status
    h[:drawer] = @drawer
    h[:word] = @word
    h[:drawing] = @drawing if @drawing
    h
  end
end
