class FavouritesController < ApplicationController
  #before_action :set_favourite, only: %i[ show update destroy ]
  before_action :check_user_logged, only: [:create, :update, :destroy, :show]
  # GET /favourites
  # GET /favourites.json
  def index
    @favourite = Favourite.all
  end

  # GET /favourites/1
  # GET /favourites/1.json
  def show
    @favourite = Favourite.find_by(user_id: @user.id, evento_id: params[:favourite][:evento_id])
    if @favourite
      render json: "true"
    else
      render json: "false"
    end  
  end

  # POST /favourites
  # POST /favourites.json
  def create
    if(@check_user)
     @favourite = Favourite.create(favourite_params.except(:token))
      @favourite.user_id = @user.id
      if @favourite.save
     # render status: :created, location: @favourite
      else
        render json: @favourite.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /favourites/1
  # PATCH/PUT /favourites/1.json
  def update
    if @favourite.update(favourite_params)
      render :show, status: :ok, location: @favourite
    else
      render json: @favourite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favourites/1
  # DELETE /favourites/1.json
  def destroy
    @favourite = Favourite.find_by(user_id: @user.id, evento_id: params[:favourite][:evento_id])
    @favourite.destroy
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_favourite
      @favourite = Favourite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favourite_params
      params.require(:favourite).permit(:id,:token,:evento_id,:user_id)
    end
    def check_user_logged
      if(params[:favourite][:token].nil? or params[:favourite][:token] == "")
        @check_user = 0
        render json: {}, status: :unauthorized, location: @favourite
      else
        @user = User.find_by(:login_token => params[:favourite][:token])
        if @user.role == "customer"
          @check_user = 1
        else 
          @check_user = 0
          render json: {}, status: :unauthorized, location: @favourite
        end
      end
    end
end