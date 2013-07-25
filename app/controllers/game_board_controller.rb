class GameBoardController < WebsocketRails::BaseController
  def initialize_session
    games = Game.all
    controller_store[:games] = games
  end

  def disconnect
    return unless isPlaying?

    game = find_game currentSession[:game_id]
    game.remove_player currentSession[:player_id]

    WebsocketRails[game.channel].trigger(:player_left, { player_id: currentSession[:player_id] })
  end

  def join
    game_id = message[:game_id]
    username = message[:username]
    game = find_game game_id

    trigger_failure({ error: 'Game not found' }) unless game

    session = start_session game_id, username

    connection_store[:session] = session

    game.add_player session[:player_id], session[:username]

    WebsocketRails[game.channel].trigger(:player_joined, { name: username, player_id: session[:player_id] })
    
    trigger_success(game)
  end

  private

  def find_game(id)
    controller_store[:games].select do |game|
      game.id == id
    end.first
  end

  def currentSession
    connection_store[:session]
  end

  def isPlaying
    !connection_store[:session].nil?
  end

  def start_session(game_id, username)
    {
      game_id: game_id,
      username: username,
      player_id: SecureRandom.uuid
    }
  end

end
