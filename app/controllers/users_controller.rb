class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users.to_json(:only =>[:id, :name, :username, :phone, :image, :language, :location, :role, :created_at, :updated_at])
  end

  # GET /users/1
  def show
    render json: @user.to_json(:only =>[:id, :name, :username, :phone, :image, :language, :location, :role, :created_at, :updated_at])
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.to_json(:only =>[:id, :name, :username, :phone, :image, :language, :location, :role, :created_at, :updated_at]), status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user.to_json(:only =>[:id, :name, :username, :phone, :image, :language, :location, :role, :created_at, :updated_at])
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  #POST /login
  def login
    @user = User.find_by(:email => params[:email])
    if @user.authenticate(params[:password])
      #give_token
      token = rand(36**12).to_s(36)
      while User.find_by(:login_token => token) do
        token = rand(36**12).to_s(36)
      end
      if @user.update_attribute(:login_token, token)
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      #bad response
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #POST /logout
  def logout
    @user = User.find_by(:login_token => params[:login_token])
    if @user
      if @user.update_attribute(:login_token, nil)
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      #bad response
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:email, :name, :username, :image, :language, :location, :login_token, :password, :password_confirmation, :role, :nif, :phone)
    end
end
