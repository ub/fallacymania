class SpritesController < ApplicationController
  before_action :set_sprite, only: [:show, :edit, :update, :destroy]

  # GET /sprites
  # GET /sprites.json
  def index
    @sprites = Sprite.all
  end


  # GET /sprites/random
  # GET /sprites/random.json
  def random
    redirect_to action: "show", id: Sprite.random_id, status: :see_other #cache
  end


  # GET /sprites/1
  # GET /sprites/1.json
  def show
  end

  # GET /sprites/new
  def new
    @sprite = Sprite.new
  end

  # GET /sprites/1/edit
  def edit
  end

  # POST /sprites
  # POST /sprites.json
  def create
    @sprite = Sprite.new(sprite_params)

    respond_to do |format|
      if @sprite.save
        format.html { redirect_to @sprite, notice: 'Sprite was successfully created.' }
        format.json { render :show, status: :created, location: @sprite }
      else
        format.html { render :new }
        format.json { render json: @sprite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sprites/1
  # PATCH/PUT /sprites/1.json
  def update
    respond_to do |format|
      if @sprite.update(sprite_params)
        format.html { redirect_to @sprite, notice: 'Sprite was successfully updated.' }
        format.json { render :show, status: :ok, location: @sprite }
      else
        format.html { render :edit }
        format.json { render json: @sprite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sprites/1
  # DELETE /sprites/1.json
  def destroy
    @sprite.destroy
    respond_to do |format|
      format.html { redirect_to sprites_url, notice: 'Sprite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sprite
      @sprite = Sprite.new(:id=>params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sprite_params
      params[:sprite]
    end
end
