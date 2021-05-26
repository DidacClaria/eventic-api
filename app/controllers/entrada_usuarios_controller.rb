class EntradaUsuariosController < ApplicationController
  #before_action :set_entrada_usuario, only: [ :show, :update, :destroy ]
  before_action :check_user_logged, only: [:create,:destroy]
  before_action :set_usuario, only:[:show]
  
  
  # GET /entrada_usuarios
  # GET /entrada_usuarios.json
  def index
    @entrada_usuario = EntradaUsuario.all
    render json: @entrada_usuario.to_json(:only =>[:id, :code, :user_id, :evento_id])
  end

  # GET /entrada_usuarios/:user_id
  # GET /entrada_usuarios/:user_id.json
  def show
    @entrada_usuarios = []
    @eventos = []
    @entrada_usuarios = EntradaUsuario.all.where(:user_id => @usuario.id)
    @entrada_usuarios.each do |entra|
      event = Evento.where(id: entra.evento_id)
      @eventos.push(event)
    end
    render json: @eventos
  end

  #GET /part_evento/:evento_id
  def show_tickets_event
   
   @entrada_usuario = EntradaUsuario.all.where(:evento_id => params[:evento_id])
   
   render json: @entrada_usuario.to_json(:only => [:id, :code, :user_id])
  end
  
  #GET /participa
  def participa
    @user = User.find_by(:login_token => params[:token])
    @entrada_usuario = EntradaUsuario.find_by(user_id: @user.id, evento_id: params[:evento_id])
    if @entrada_usuario
      render json: @entrada_usuario.code.to_json
    else
      render json: {}, status: :unauthorised
    end
  end

  #PUT /ha_participat
  def ha_participat
    
    @entrada_usuario = EntradaUsuario.find_by_code(params[:code])
    @evento = Evento.find_by(id_creator: params[:id_creator], id: @entrada_usuario.evento_id)
    if @evento
      @entrada_usuario.ha_participat = true
      @entrada_usuario.save
      render json: @entrada_usuario
    else
      render json: {}, status: :unauthorised
    end
  end

  # POST /entrada_usuarios
  # POST /entrada_usuarios.json
  def create
    if(@check_user)
      @entrada_usuario = EntradaUsuario.create(entrada_usuario_params.except(:token))
      @entrada_usuario.code = SecureRandom.hex
      @entrada_usuario.user_id = @user.id     
      if @entrada_usuario.save
        @evento = Evento.find_by_id(@entrada_usuario.evento_id)
        @evento.participants = @evento.participants + 1
        @evento.save
        @msg = "actualitzat i participant"
        render json: @msg, status: :created, location: @entrada_usuario
      else
        render json: @entrada_usuario.errors, status: :unprocessable_entity
      end
    else
      @msg="ERROR: Usuari no autoritzat"
      render json: @msg, status: :unauthorized, location: @entrada_usuario
    end
  end

  # DELETE /entrada_usuarios
  # DELETE /entrada_usuarios.json
  def destroy
    if(@check_user)
      @entrada_usuario = EntradaUsuario.find_by(user_id: @user.id, evento_id: params[:evento_id])
    
      @evento = Evento.find_by_id(@entrada_usuario.evento_id)

      @entrada_usuario.destroy
      @evento.participants = @evento.participants - 1
      @evento.save
    else
      @msg="ERROR: Usuari no autoritzat"
      render json: @msg, status: :unauthorized, location: @entrada_usuario
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_entrada_usuario
      @entrada_usuario = EntradaUsuario.find(params[:id])
    end

    
    def set_usuario
      @usuario = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entrada_usuario_params
      params.permit(:code, :user_id, :evento_id, :token, :id_creator)
    end
    
    def check_user_logged
      if (params[:token].nil? or params[:token] == "")
        @check_user=false
      else
        @user = User.find_by(:login_token => params[:token])
        if @user.nil?
          @check_user=false
        elsif @user.role == "customer" or @user.role == "google"
          @check_user=true
        else
          @check_user=false
        end
      end
    end
end
