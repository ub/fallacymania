class PlayersController < ApplicationController
  include ChannelNames
  include GamesHelper
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_game



  # GET /players
  def index
    @players = @game.players.all
  end

  # GET /players/1
  def show
  end

  # GET /game/1/players/new
  def new
    @player = @game.players.build(user: current_user)
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
      channel_name = redisCN_playerlist_for_game(@game)
      logger.info "Channel name:" + channel_name + ", player-json:" + player_short_json
      ok=redis.publish(channel_name,player_short_json)
      logger.info "PUBLISH:" + ok.to_s
      redis.quit

      if i_am_the_game_master(@game)
        redirect_to edit_game_path(@game), notice: 'You have joined the game.'
      else
        redirect_to game_path(@game), notice: 'You have joined the game.'
      end
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

=begin
    We have very simple Redis protocol:
    - publish json-string when player is created (joins the game)
    - publish json-string preceded by minus (-) when player is destroyed (leaves the game)
    - redirect to next page in workflow when the first char is gt (>) sign
=end

  # DELETE /players/1
  def destroy   #Destroy means exit game
  logger.info "Destroying player #{@player.id}"
    player_short_json = @player.slice(:nick, :created_at).to_json
    if @player.destroy
      redis = Redis.new
      logger.info "[delete]URL type:" + game_stream_url(@game).class.to_s
      channel_name = redisCN_playerlist_for_game(@game)
      logger.info "[delete]Channel name:" + channel_name + ", player-json:" + player_short_json
      ok=redis.publish(channel_name,"-#{player_short_json}") #FIXME: refactor create like this
      logger.info "[delete]PUBLISH:" + ok.to_s
      redis.quit
    end

    if i_am_the_game_master(@game)
      redirect_to edit_game_path(@game), notice: 'You are not playing your game anymore'
    else
      redirect_to marquee_path
    end
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
