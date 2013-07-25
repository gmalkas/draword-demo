class Game < ActiveRecord::Base
  def players
    @players ||= []
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
end
