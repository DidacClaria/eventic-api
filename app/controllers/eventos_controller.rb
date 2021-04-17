class EventosController < ApplicationController
  before_action :set_evento, only:[:show, :update, :destroy]

  #GET /evento
  #GET /evento.json
  def index
  	@evento = Evento.all
  	render json: @evento.to_json(:only =>[:id, :title, :location, :image, :start_time, :participants])
  end

  #GET /evento/id
  #GET /evento/id.json
  def show
  render json: @evento
  end

  #GET /evento/token
  #GET /evento/token.json
  def show_comp
  @usuari = Usuari.where(token: token)
  @evento=Evento.where(:id_creator => @usuari.id)
  render json: @evento
  end

  # POST /crearevento
  # POST /crearevento.json
  def create
    #@usuari = Usuari.where(token: token)
    #if(@usuari != nil)
  	 @evento = Evento.create(event_params)
     @evento.participants=0
    #@evento.id_creator=@usuari.id
     if @evento.save
       params[:evento][:event_image_data].each do |file|
         @evento.event_images.create!(:image => file)
       end
       render json: @evento, status: :created, location: @evento
     else
       render json: @evento.errors, status: :unprocessable_entity
     end
   #end
  end

  #PUT /evento/id
  #PUT /evento/id.json
  def update
    @evento.update(event_params)
    @evento.save
  end

  # DELETE /evento/id
  # DELETE /evento/id.json
  def destroy
    @evento.destroy
  end

private

 def set_evento
      @evento = Evento.find(params[:id])
  end

def event_params
    params.require(:evento).permit(:title, :prova ,:description, :date, :capacity,:location,:price, :URL_page, :URL_share, :start_time, :end_time, :token, :event_image_data => [])
  end
end
