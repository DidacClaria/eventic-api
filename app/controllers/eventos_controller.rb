class EventosController < ApplicationController
  before_action :set_evento, only:[:show_tags, :show, :update, :destroy]
  before_action :check_logged_company, only: [:create, :update, :destroy]

  #GET /evento
  #GET /evento.json
  def index
    @evento = Evento.all
    render json: @evento
  end

  #GET /evento/id
  #GET /evento/id.json
  def show
    render json: @evento
  end

  #GET /evento/comp
  #GET /evento/comp.json
  def comp
    @evento=Evento.where(:id_creator => params[:company_id].to_i)
    render json: @evento
  end

  # POST /crearevento
  # POST /crearevento.json
  def create
    if(@check)
      @evento = Evento.create(event_params.except(:token))
      @evento.participants=0
      @evento.id_creator=params[:company_id].to_i
      if @evento.save
        #params[:evento][:event_image_data].each do |file|
         # @evento.event_images.create!(:image => file)
       # end
        render json: @evento, status: :created, location: @evento
      else
        render json: @evento.errors, status: :unprocessable_entity
      end
    end
  end

  #PUT /evento/id
  #PUT /evento/id.json
  def update
    if(@check)
      @evento.update(event_params.except(:token))
      if @evento.save
        render json: @evento, status: :ok, location: @evento
      else
        render json: @evento.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /evento/id
  # DELETE /evento/id.json
  def destroy
    if(@check)
      if @evento.destroy
        render json: {}, status: :ok, location: @evento
      else
        render json: @evento.errors, status: :unprocessable_entity
      end
    end
  end

private

 def set_evento
      @evento = Evento.find(params[:id])
  end

  def check_logged_company
    if (params[:token].nil? or params[:token] == "")
      @check=0
      #render json: {}, status: :unauthorized, location: @evento
    else
      @user = User.find_by(:login_token => params[:token])
      if @user.role == "company"
        @check=1
      else
        @check=0
       # render json: {}, status: :unauthorized, location: @evento
      end
    end
  end

  def event_params
    params.permit(:title,:description, :start_date, :end_date, :capacity,:latitude, :longitude,:price, :URL_page, :URL_share, :start_time, :end_time, :token, :company_id, :event_image_data => [])
  end
end
