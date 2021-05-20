class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy]

  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings_company
  # GET /ratings_company.json
  def ratings_company
    @user = User.find_by(:id => params[:company_id])
    if @user.rating ==  nil or @user.rating == -1
      @message="La companyia no ha estat valorada"
      render json: @message
    else
      render json: @user.rating.to_json
    end
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @rating = Rating.new(rating_params)
    auto = false
    if rating_params[:company_id]==rating_params[:customer_id]
      auto=true
    end
    if auto
      @message="ERROR: El client i la companyia han de ser diferents"
      render json: @message
    elsif @rating.save
      @valoracions = []
      @sum = 0
      @valoracions = Rating.where(company_id: params[:company_id])
      @valoracions.each do |rt|
        @sum = @sum + rt.rating
        @valoracio = @sum / @valoracions.count
      end
      @user = User.find_by(:id => params[:company_id])
      @user.rating = @valoracio
      @user.save()
      render :show, status: :created, location: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    if @rating.update(rating_params)
      render :show, status: :ok, location: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    cmp_id=@rating.company_id
    @valoracions = Rating.where(company_id: cmp_id)
    @valoracio = 0
    #si es lultima valoració es queda amb -1
    if @valoracions.count == 1
      @valoracio = -1
    else #sino es recalcula
      @sum = 0
      @valoracions.each do |rt|
        @sum = @sum + rt.rating
      end
      @valoracio = (@sum-@rating.rating) / (@valoracions.count-1)
    end
    @user = User.find_by(:id => cmp_id)
    @user.rating = @valoracio
    @user.save()
    #finalment destruim
    @rating.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.permit(:rating, :text, :company_id, :customer_id)
    end
end
