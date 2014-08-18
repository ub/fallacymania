class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_game



  # GET /players
  def index
    @players = @game.players.all
  end

  # GET /players/1
  def show
  end

  # GET /players/new
  def new
    @player = @game.players.new
    @player.user = current_user
    @player.nick = current_user.name #TODO make sure the nick is unique
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  def create
    @player = @game.players.new(player_params)

    if @player.save
      player_short_json=@player.slice(:nick, :created_at).to_json
      redis = Redis.new
      logger.info "URL type:" + game_stream_url(@game).class.to_s
      channel_name = "-#{game_stream_url(@game)}-"
      logger.info "Channel name:" + channel_name + ", player-json:" + player_short_json
      ok=redis.publish(channel_name,player_short_json)
      logger.info "PUBLISH:" + ok.to_s
      #redis.quit


      redirect_to [@game, @player], notice: 'Player has joined the game.'
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
  def destroy   #Destroy means exit game
    @player.destroy
    redirect_to game_players_url(@game), notice: 'Player was successfully destroyed.'
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
      params.require(:player).permit(:user_id, :nick)
    end
end
