require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { email: "newuser@gmail.com", image: @user.image, language: @user.language, longitude: @user.longitude, latitude: @user.latitude, login_token: nil, name: @user.name, nif: @user.nif, password: @user.password_digest, password_confirmation: @user.password_digest, phone: @user.phone, role: @user.role, username: @user.username }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should login user" do
    #first we will create a new user
    post users_url, params: { email: "login@gmail.com", password: "123456789", password_confirmation: "123456789" }, as: :json
    assert_response :success
    #then we will log him up
    post '/login', params: { email: "login@gmail.com", password: "123456789" }, as: :json
    assert_response :success

  end

  test "should logout user" do
    #first we will create a new user
    post users_url, params: { email: "logout@gmail.com", password: "123456789", password_confirmation: "123456789" }, as: :json
    assert_response :success
    #then we will log him up to obtain the login_token
    post '/login', params: { email: "logout@gmail.com", password: "123456789" }, as: :json
    assert_response :success
    login_response = JSON.parse(@response.body)
    #finally we will log him out
    post '/logout', params: { login_token: login_response["login_token"] }
    assert_response :success
  end

  test "should update user" do
    #first we will create a new user
    post users_url, params: { email: "updating@gmail.com", password: "123456789", password_confirmation: "123456789" }, as: :json
    assert_response :success
    user_id = JSON.parse(@response.body)["id"]
    #then we will log him up
    post '/login', params: { email: "updating@gmail.com", password: "123456789" }, as: :json
    assert_response :success
    login_response = JSON.parse(@response.body)
    #once we've done all that we will try to update the fields of the model
    patch user_url(user_id), params: { login_token: login_response["login_token"], id: user_id, image: @user.image, language: @user.language, name: @user.name, password: @user.password_digest, password_confirmation: @user.password_digest, username: @user.username }, as: :json
    assert_response :success
  end

  test "should destroy user" do
    #first we will create a new user
    post users_url, params: { email: "destroy@gmail.com", password: "123456789", password_confirmation: "123456789" }, as: :json
    assert_response :success
    user_id = JSON.parse(@response.body)["id"]
    #then we will log him up
    post '/login', params: { email: "destroy@gmail.com", password: "123456789" }, as: :json
    assert_response :success
    login_response = JSON.parse(@response.body)
    #once we've done all that we will destroy his information
    assert_difference('User.count', -1) do
      delete user_url(user_id), params: {login_token: login_response["login_token"], id: user_id}, as: :json
    end
    assert_response 204
  end

end
