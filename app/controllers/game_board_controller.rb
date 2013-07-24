class GameBoardController < WebsocketRails::BaseController
  def initialize_session
    games = Game.all.map &:to_json
    controller_store[:games] = games
  end

  def join
    trigger_success({ message: "Welcome!" })
  end
end
