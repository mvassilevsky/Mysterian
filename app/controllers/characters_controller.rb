class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /games/:game_id/characters
  # GET /games/:game_id/characters.json
  def index
    @game = Game.find(params[:game_id])
    @characters = @game.characters
  end

  # GET /games/:game_id/characters/1
  # GET /games/:game_id/characters/1.json
  def show
  end

  # GET /games/:game_id/characters/new
  def new
    @character = Character.new
  end

  # GET /games/:game_id/characters/1/edit
  def edit
    @character = Character.find(params[:id])
    @game = @character.game
  end

  # POST /games/:game_id/characters
  # POST /games/:game_id/characters.json
  def create
    @character = Character.new(character_params)
    @character.game_id = params[:game_id]
    
    respond_to do |format|
      if @character.save
          GameUser.create(game: @character.game, user: @character.user)
          format.html { redirect_to game_path(@character.game_id), notice: 'Character was successfully created.' }
          format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end

      # begin
      #   Character.transaction do
      #     @character.save!
      #     # byebug
      #     GameUser.create!(game: @character.game, user: @character.user)
      #   end
      #   format.html { redirect_to game_path(@character.game_id), notice: 'Character was successfully created.' }
      #   format.json { render :show, status: :created, location: @character }
      # rescue
      #   @game = Game.find(@character.game_id)
      #   @characters = @game.characters
      #   format.html { render "games/show", notice: 'Error creating character.' }
      #   format.json { render json: @character.errors, status: :unprocessable_entity }
      # end
    end
  end

  # PATCH/PUT /games/:game_id/characters/1
  # PATCH/PUT /games/:game_id/characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to game_path(@character.game_id), notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/:game_id/characters/1
  # DELETE /games/:game_id/characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to game_path(@character.game_id), notice: 'Character was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:name, :character_sheet, :game_id, :user_id)
    end
end
