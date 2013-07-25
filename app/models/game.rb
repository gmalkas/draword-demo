class Game < ActiveRecord::Base
  after_initialize :setup

  def setup
    @players = []
    @word = "Banana"
    @status = "ingoing"
  end

  def players
    @players
  end

  def add_player(player_id, username)
    players << Struct.new(:id, :name).new(player_id, username)
  end

  def remove_player(player_id)
    players.delete_if { |player| player.id == player_id }
  end

  def channel
    "game-#{id}"
  end

  def as_json(options = {})
    h = super(options)
    h[:players] = players
    h[:status] = @status
    h
  end
end
