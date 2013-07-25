class GameBoardController < WebsocketRails::BaseController
  def initialize_session
    games = Game.all
    controller_store[:games] = games
  end

  def disconnect
    return unless isPlaying?

    game = find_game currentSession[:game_id]
    game.remove_player currentSession[:player_id]

    WebsocketRails[game.channel].trigger('player:left', { id: currentSession[:player_id] })
  end

  def join
    game_id = message[:game_id]
    username = message[:username]
    game = find_game game_id

    trigger_failure({ error: 'Game not found' }) unless game

    session = start_session game_id, username

    connection_store[:session] = session

    game.add_player session[:player_id], session[:username]

    WebsocketRails[game.channel].trigger('player:joined', { name: username, id: session[:player_id] })
    
    trigger_success({ game: game, id: session[:player_id] })
  end

  def guess
    trigger_failure({ error: 'Must have joined a game!' }) unless isPlaying?

    game = find_game currentSession[:game_id]
    trigger_failure({ error: 'Game not found' }) unless game
    
    guess = message[:word]

    correct = game.correct_guess? guess
    broadcast_message('guess:new', { game_id: game.id, username: currentSession[:username], word: guess, correct: correct })

    if correct
      broadcast_message('game:over', { game_id: game.id, winner: currentSession[:username], word: guess })
    end
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

  def isPlaying?
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
