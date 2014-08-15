class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_game, only: [:new]

  # GET /players
  def index
    @players = Player.all
  end

  # GET /players/1
  def show
  end

  # GET /players/new
  def new
    @player = @game.players.build
    @player.user = current_user
    @player.nick = current_user.name #TODO make sure the nick is unique
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

   def set_game
     @game = Game.find(params[:game_id])
   end

    # Only allow a trusted parameter "white list" through.
    def player_params
      params[:player]
    end
end
