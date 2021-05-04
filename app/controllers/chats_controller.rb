class ChatsController < ApplicationController
  before_action :set_chat, only: [ :show, :update, :destroy ]

  # GET /chats
  # GET /chats.json
  def index
    @chats = Chat.all
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    @chat = Chat.where(id: params[:id])
    render json: @chat
  end

  #GET /user_chats
  def user_chats
    if params[:customer_id]
      @chats = Chat.all.where(customer_id: params[:customer_id])
    else
      @chats = Chat.all.where(company_id: params[:company_id])
    end
    render json: @chats
  end

  # POST /chats
  # POST /chats.json
  def create
    @chat = Chat.new(chat_params.except(:token))

    if @chat.save
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    if @chat.update(chat_params)
      render :show, status: :ok, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.permit(:evento_id, :customer_id, :company_id)
    end
end
