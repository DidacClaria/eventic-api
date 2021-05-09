class ValoraciosController < ApplicationController
  before_action :set_valoracio, only: %i[ show update destroy ]

  # GET /valoracios
  # GET /valoracios.json
  def index
    @valoracios = Valoracio.all
  end

  # GET /valoracios/1
  # GET /valoracios/1.json
  def show
  end

  # POST /valoracios
  # POST /valoracios.json
  def create
    @valoracio = Valoracio.new(valoracio_params)

    if @valoracio.save
      render :show, status: :created, location: @valoracio
    else
      render json: @valoracio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /valoracios/1
  # PATCH/PUT /valoracios/1.json
  def update
    if @valoracio.update(valoracio_params)
      render :show, status: :ok, location: @valoracio
    else
      render json: @valoracio.errors, status: :unprocessable_entity
    end
  end

  # DELETE /valoracios/1
  # DELETE /valoracios/1.json
  def destroy
    @valoracio.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valoracio
      @valoracio = Valoracio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def valoracio_params
      params.require(:valoracio).permit(:rating, :text)
    end
end
