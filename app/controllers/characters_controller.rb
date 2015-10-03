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
    @player = User.find_by(email: params[:character][:player_email])
    @character.user_id = @player.id unless @player.nil? #change this when we get registration working

    respond_to do |format|
      if @character.save
        if @player.nil? and !params[:player_email].blank?
          format.html { redirect_to game_path(@character.game_id),
                        notice: 'Character was successfully created, but ' +
                                'there is no user with that email address.' }
        elsif !params[:character][:player_email].blank?
          game_user = GameUser.find_by(user_id: @character.user.id,
                                       game_id: @character.game.id)
          GameUser.create(user_id: @player.id,
                          game_id: @character.game.id) unless game_user
          UserMailer.invite_email(@player, @character.game, @character).deliver
          format.html { redirect_to game_path(@character.game_id),
                        notice: 'Character was successfully created.' }
        else
          format.html { redirect_to game_path(@character.game_id),
                        notice: 'Character was successfully created.' }
        end
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors,
                      status: :unprocessable_entity }
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
    @player = User.find_by(params[:character][:player_email])
    new_user_assigned = false

    #change this when we have registration working
    unless @player.nil?
      new_user_assigned = true
      @character.user_id = @player.id
    end

    respond_to do |format|
      if @character.update(character_params)
        if @player.nil? and !params[:character][:player_email].blank?
          format.html { redirect_to game_path(@character.game_id),
                        notice: 'Character was successfully updated, but ' +
                        'there is no user with that email address.' }
        else
          if new_user_assigned
            game_user = GameUser.find_by(user_id: @character.user.id,
                                         game_id: @character.game.id)
            GameUser.create(user_id: @character.user.id,
                            game_id: @character.game.id) unless game_user
            UserMailer.invite_email(@player, @character.game,
                                    @character).deliver
          end
          format.html { redirect_to game_path(@character.game_id),
                        notice: 'Character was successfully updated.' }
        end
        format.json { render :show, status: :ok,
                      location: game_path(@character.game_id) }
      else
        format.html { render :edit }
        format.json { render json: @character.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/:game_id/characters/1
  # DELETE /games/:game_id/characters/1.json
  def destroy
    @game_user = GameUser.find_by(game: @character.game, user: @character.user)
    @game_user.destroy unless @game_user.nil?
    @character.destroy
    respond_to do |format|
      format.html { redirect_to game_path(@character.game_id),
                    notice: 'Character was successfully deleted.' }
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
      params.require(:character).permit(:name, :character_sheet, :game_id,
                                        :player_email)
    end
end
