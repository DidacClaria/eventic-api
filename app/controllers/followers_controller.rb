class FollowersController < ApplicationController
  before_action :set_evento, only:[:show, :update, :destroy]
  #before_action :check_logged_user, only: [:create, :update, :destroy]

  #GET /follower
  #GET /follower.json
  def index
    
  end

  #GET /followerid
  #GET /follower/id.json
  def show
    
  end

  #GET /follower/comp
  #GET /follower/comp.json
  def comp
    
  end

  # POST /afegirfollower
  # POST /afegirfollower.json
  def create
    #if(@check)
      @follower = Follower.create(follower_params.except(:token))
      if @follower.save
        render json: @follower, status: :created, location: @follower
      else
        render json: @follower.errors, status: :bad_request
      end
    #end
  end

  #PUT /follower/id
  #PUT /follower/id.json
  def update
    if(@check)
      @follower.update(event_params.except(:token))
      if follower.save
        render json: @follower, status: :ok, location: @follower
      else
        render json: @follower.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /follower/id
  # DELETE /follower/id.json
  def destroy
    if(@check)
      
    end
  end

private

 def set_evento

  end

  def check_logged_company
    if (params[:followers][:token].nil? or params[:followers][:token] == "")
      @check=0
      render json: {}, status: :unauthorized, location: @follower
    else
      @user = User.find_by(:login_token => params[:followers][:token])
      if @user.role == "user"
        @check=1
      else
        @check=0
        render json: {}, status: :unauthorized, location: @follower
      end
    end
  end

  def follower_params
    params.require(:followers).permit(:user_id, :company_id,:token)
  end
end
