class GamesController < ApplicationController
  include ChannelNames

  before_action :set_game, only: [:show, :edit, :play, :update, :start, :destroy]


  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1/play
  def play
    redirect_to edit_game_path(@game) #TODO: wrong. depends on user roled and game status
  end

  # GET /games/1
  def show
    @players = @game.players
    @continue_url=game_round_path(@game,1)
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  # edit is action for games in 'OPEN' state
  # gamemaster may tune the game options, join or start the game;
  # other participants may leave the game or just passively wait
  #
  # Future versions: players may participate in opening game chat (ONLINE)
  # game master may terminate the game at will
  def edit
    @players = @game.players
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.game_master = current_user

    if @game.save
      redirect_to edit_game_path( @game), notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # PATCH/PUT /games/1/start
  def start
    @game.update!(status: 'PLAYING')
    round = @game.rounds.create!
    logger.info "[start] game update success" #FIXME: refactor (see players_controller) (use concern?)
    redis = Redis.new
    channel_name = redisCN_playerlist_for_game(@game)
    logger.info "[start]Channel name:" + channel_name
    ok=redis.publish(channel_name,">{}") #TODO: game_round_path(@game,1)
    logger.info "[start]PUBLISH:" + ok.to_s
    redis.quit

    # assert ordinal should be 1

    redirect_to_path = game_round_path(@game, round.ordinal)
    redirect_to redirect_to_path, notice: 'Game was successfully started.'
  rescue ActiveRecord::RecordInvalid => invalid
      logger.info "[start] game update  or round create failure #{invalid}"
      redirect_to :back #TODO: redirect to error
  end



  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params[:game].permit!
      #tmp=params[:game]
      #logger.info "game_params %s" % tmp.to_s
      #tmp
    end
end
