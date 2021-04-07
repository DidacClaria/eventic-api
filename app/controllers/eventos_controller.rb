class EventosController < ApplicationController
 
  #GET /evento
  #GET /evento.json
  def index
  	
  	@evento = Evento.all
  	render json: @evento

  end

  # POST /crearevento
  # POST /crearevento.json
  def create
  	 @evento = Evento.create(event_params)
  	 @evento.save 	 
   end

private
def event_params
    params.require(:evento).permit(:nomesdeveniment,:descripcio)
  end
end
