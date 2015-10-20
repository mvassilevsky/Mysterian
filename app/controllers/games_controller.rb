class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    if current_user.nil?
      @games = Game.all
    else
      @owned_games = current_user.owned_games
      @played_games = current_user.played_games
      @characters = current_user.characters
      @played_games_and_characters = {}
      @played_games.each do |played_game|
        character = @characters.find_by(game_id: played_game.id)
        @played_games_and_characters[played_game] = character
      end
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @characters = @game.characters.includes(:abilities)
    @character = Character.new
    game_users = GameUser.where(game_id: @game.id)
    @users_without_characters = []
    game_users.each do |game_user|
      unless Character.exists?(game_id: @game.id, user_id: game_user.user.id)
        @users_without_characters << game_user.user
      end
    end
    @invited_users_without_characters = InvitedUser.where(game_id: @game.id,
                                                          character_id: nil)
    @ability_counts = Hash.new(0)
    @has_abilities = false
    @characters.each do |character|
      character.abilities.each do |ability|
        @has_abilities = true
        @ability_counts[ability] += 1
      end
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.owner_id = current_user.id

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game,
                      notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game,
                      notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :show }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url,
                    notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :description)
    end
end
