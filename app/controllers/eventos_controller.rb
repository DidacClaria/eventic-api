class EventosController < ApplicationController
 
  # POST /crearevento
  # POST /crearevento.json
  def create
  	 @evento = Evento.create(nomesdeveniment: "prova5")
  	 @evento.save 	 
   end

private
def event_params
    params.require(:evento).permit(:nomesdeveniment)
  end
end
