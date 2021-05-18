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
    @ratings = []
    @sum = 0
    @ratings = Rating.where(company_id: params[:company_id])
    @ratings.each do |rt|
      @sum = @sum + rt.rating
      @rating = @sum / @ratings.count
    end
    @user = User.find_by(:id => params[:company_id])
    @user.rating = @rating
    #@user.send(:update)
    if @rating==nil
      @rating=-1
    end
    render json: @rating.to_json
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
