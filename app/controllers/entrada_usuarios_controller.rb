class EntradaUsuariosController < ApplicationController
  #before_action :set_entrada_usuario, only: [ :show, :update, :destroy ]
  before_action :check_user_logged, only: [:create, :update, :destroy]
  # GET /entrada_usuarios
  # GET /entrada_usuarios.json
  def index
    @entrada_usuario = EntradaUsuario.all
    render json: @entrada_usuario.to_json(:only =>[:id, :code, :user_id, :evento_id])
  end

  # GET /entrada_usuarios/:user_id
  # GET /entrada_usuarios/1.json
  def show
    @entrada_usuario = EntradaUsuario.all.where(:user_id => [:user_id])
    render json: @entrada_usuario
  end
  #GET /part_evento/:evento_id
  def show_tickets_event
   
   @entrada_usuario = EntradaUsuario.all.where(:evento_id => params[:evento_id])
   
   render json: @entrada_usuario
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
        render :show, status: :created, location: @entrada_usuario
     else
        render json: @entrada_usuario.errors, status: :unprocessable_entity
     end
    end
  end

  # PATCH/PUT /entrada_usuarios/1
  # PATCH/PUT /entrada_usuarios/1.json
  def update
    if @entrada_usuario.update(entrada_usuario_params)
      render :show, status: :ok, location: @entrada_usuario
    else
      render json: @entrada_usuario.errors, status: :unprocessable_entity
    end
  end

  # DELETE /entrada_usuarios/1
  # DELETE /entrada_usuarios/1.json
  def destroy
 
    @entrada_usuario = EntradaUsuario.find_by(user_id: @user.id, evento_id: params[:entrada_usuario][:evento_id])
  
    @evento = Evento.find_by_id(@entrada_usuario.evento_id)
 
    @entrada_usuario.destroy
    @evento.participants = @evento.participants - 1
    @evento.save
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_entrada_usuario
      @entrada_usuario = EntradaUsuario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entrada_usuario_params
      params.require(:entrada_usuario).permit(:code, :user_id, :evento_id, :token)
    end
    
    def check_user_logged
      if(params[:entrada_usuario][:token].nil? or params[:entrada_usuario][:token] == "")
        @check_user = 0
        render json: {}, status: :unauthorized, location: @entrada_usuario
      else
        @user = User.find_by(:login_token => params[:entrada_usuario][:token])
        if @user.role == "customer"
          @check_user = 1
        else 
          @check_user = 0
          render json: {}, status: :unauthorized, location: @entrada_usuario
        end
      end
    end
end
