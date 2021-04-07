class UsuarisController < ApplicationController
  before_action :set_usuari, only: [:show, :update, :destroy]

  # GET /usuaris
  def index
    @usuaris = Usuari.all

    render json: @usuaris
  end

  # GET /usuaris/1
  def show
    render json: @usuari
  end

  # POST /usuaris
  def create
    @usuari = Usuari.new(usuari_params)

    if @usuari.save
      render json: @usuari, status: :created, location: @usuari
    else
      render json: @usuari.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /usuaris/1
  def update
    if @usuari.update(usuari_params)
      render json: @usuari
    else
      render json: @usuari.errors, status: :unprocessable_entity
    end
  end

  # DELETE /usuaris/1
  def destroy
    @usuari.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuari
      @usuari = Usuari.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usuari_params
      params.require(:usuari).permit(:email, :name, :username, :image, :language, :location, :login_token, :password, :password_confirmation, :tipus)
    end

end
