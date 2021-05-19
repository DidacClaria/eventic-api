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
  # GET /entrada_usuarios/1.json
  def show
    @entrada_usuario = EntradaUsuario.all.where(:user_id => @usuario.id)
    render json: @entrada_usuario.to_json(:only =>[:evento_id])
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
      render json: @entrada_usuario.code
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
      render json:true
    else
      render json: false
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
        render json: "actualitzat i participant"
     else
        render json: @entrada_usuario.errors, status: :unprocessable_entity
     end
    end
  end

  # PATCH/PUT /entrada_usuarios/1
  # PATCH/PUT /entrada_usuarios/1.json
  #def update
   # if @entrada_usuario.update(entrada_usuario_params)
    #  render :show, status: :ok, location: @entrada_usuario
    #else
     # render json: @entrada_usuario.errors, status: :unprocessable_entity
    #end
  #end

  # DELETE /entrada_usuarios/1
  # DELETE /entrada_usuarios/1.json
  def destroy
 
    @entrada_usuario = EntradaUsuario.find_by(user_id: @user.id, evento_id: params[:evento_id])
  
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

     def set_usuario
      @usuario = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entrada_usuario_params
      params.permit(:code, :user_id, :evento_id, :token, :id_creator)
    end
    
    def check_user_logged
      if(params[:token].nil? or params[:token] == "")
        @check_user = 0
        #render json: {}, status: :unauthorized, location: @entrada_usuario
      else
        @user = User.find_by(:login_token => params[:token])
        if @user.role == "customer"
          @check_user = 1
        else 
          @check_user = 0
        #  render json: {}, status: :unauthorized, location: @entrada_usuario
        end
      end
    end
end
