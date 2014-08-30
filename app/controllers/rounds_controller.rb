class RoundsController < ApplicationController
  before_action :set_game
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  def index
    @rounds = Round.all
  end

  # GET /rounds/1
  def show
  end

  # GET /rounds/new
  def new
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  def create
    @round = Round.new(round_params)

    if @round.save
      redirect_to @round, notice: 'Round was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /rounds/1
  def update
    if @round.update(round_params)
      redirect_to @round, notice: 'Round was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /rounds/1
  def destroy
    @round.destroy
    redirect_to rounds_url, notice: 'Round was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find_by(game_id: params[:game_id], ordinal: params[:id])
      logger.info "well so..."
    end

    def set_game
      @game = Game.find(params[:game_id])
    end

    # Only allow a trusted parameter "white list" through.
    def round_params
      params.require(:round).permit(:ordinal, :game, :workflow_state)
    end
end
