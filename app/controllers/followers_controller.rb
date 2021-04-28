class FollowersController < ApplicationController
  before_action :set_follower, only:[:show, :update, :destroy]
  before_action :check_logged_customer, only: [:create, :update, :destroy]

  #GET /follower
  #GET /follower.json
  def index
    
  end

  #GET /followerid
  #GET /follower/id.json
 # def show
    
  #end

  #GET /follower/comp
  #GET /follower/comp.json
  def comp
    
  end

  # POST /afegirfollower
  # POST /afegirfollower.json
  def create
    if(@check)
      @customer = User.find_by_id(params[:customer_id])    
      @company= User.find_by_id(params[:company_id])
      if(Follower.all.where('company_id = ? and customer_id =?', params[:company_id],params[:customer_id]).first.nil? && @customer.role == "customer" && @company.role=="company")
        @follower = Follower.create(follower_params.except(:token))
        if @follower.save
          render json: @follower, status: :created, location: @follower
        else
          render json: @follower.errors, status: :bad_request
        end
      else 
        render json: {}, status: :conflict
      end
    end
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

  # DELETE /follower
  # DELETE /follower.json
  def destroy
   if(@check)   
      if @follower.destroy
        render json: {}, status: :ok, location: @follower
      else
        render json: @follower.errors, status: :unprocessable_entity
      end
    end
  end

private

 def set_follower
    @follower = Follower.all.where('company_id = ? and customer_id =?', params[:company_id],params[:customer_id]).first
    if(!@follower.nil?)
      @follower = Follower.find_by_id(@follower.id)
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def check_logged_customer
    if (params[:token].nil? or params[:token] == "")
      @check=0
      render json: {}, status: :unauthorized, location: @follower
    else
      @user = User.find_by(:login_token => params[:token])
      if @user.role == "customer"
        @check=1
      else
        @check=0
        render json: {}, status: :unauthorized, location: @follower
      end
    end
  end

  def follower_params
    params.permit(:company_id, :customer_id, :token)
  end
end
