class GamesController < ApplicationController
  respond_to :json

  def index
    respond_with(Game.all)
  end

  def show
    game = Game.find params[:id]
    respond_with(game)
  end

  def create
    game = Game.new game_params
    if game.save
      respond_with(game)
    else
      respond_with({ errors: game.errors })
    end 
  end

  private

  def game_params
    params.required(:game).permit(:title)
  end
end
