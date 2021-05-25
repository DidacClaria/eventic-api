require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating = ratings(:one)
  end

  test "should get index" do
    get ratings_url, as: :json
    assert_response :success
  end

  test "should create rating" do
    post users_url, params: { email: "company@gmail.com", password: "123456789", password_confirmation: "123456789", role: "company" }, as: :json
    company_resp=JSON.parse(@response.body)
    assert_response :success
    #Then we will create a new user
    post users_url, params: { email: "customer@gmail.com", password: "123456789", password_confirmation: "123456789", role: "customer" }, as: :json
    customer_resp = JSON.parse(@response.body)
    assert_response :success

    assert_difference('Rating.count') do
      post ratings_url, params: { rating: @rating.rating, text: @rating.text, company_id: company_resp["id"], customer_id: customer_resp["id"]}, as: :json
    end

    assert_response 201
  end

  test "should show rating" do
    get rating_url(@rating), as: :json
    assert_response :success
  end

  test "should update rating" do
    post users_url, params: { email: "company@gmail.com", password: "123456789", password_confirmation: "123456789", role: "company" }, as: :json
    company_resp=JSON.parse(@response.body)
    assert_response :success
    #Then we will create a new user
    post users_url, params: { email: "customer@gmail.com", password: "123456789", password_confirmation: "123456789", role: "customer" }, as: :json
    customer_resp = JSON.parse(@response.body)
    assert_response :success
    patch rating_url(@rating), params: { rating: @rating.rating, text: @rating.text, company_id: company_resp["id"], customer_id: customer_resp["id"] }, as: :json
    assert_response 200
  end

  test "should destroy rating" do
    post users_url, params: { email: "company@gmail.com", password: "123456789", password_confirmation: "123456789", role: "company" }, as: :json
    company_resp=JSON.parse(@response.body)
    assert_response :success
    #Then we will create a new user
    post users_url, params: { email: "customer@gmail.com", password: "123456789", password_confirmation: "123456789", role: "customer" }, as: :json
    customer_resp = JSON.parse(@response.body)
    assert_response :success

    assert_difference('Rating.count') do
      post ratings_url, params: { rating: @rating.rating, text: @rating.text, company_id: company_resp["id"], customer_id: customer_resp["id"]}, as: :json   
    end
    rat_resp=JSON.parse(@response.body) 
    assert_difference('Rating.count', -1) do
      delete rating_url(rat_resp["id"]), as: :json
    end

    assert_response 204
  end
end
