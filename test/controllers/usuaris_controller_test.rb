require "test_helper"

class UsuarisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuari = usuaris(:one)
  end

  test "should get index" do
    get usuaris_url, as: :json
    assert_response :success
  end

  test "should create usuari" do
    assert_difference('Usuari.count') do
      post usuaris_url, params: { usuari: { email: @usuari.email, image: @usuari.image, language: @usuari.language, location: @usuari.location, name: @usuari.name, password: 'secret', password_confirmation: 'secret', tipus: @usuari.tipus, login_token: @usuari.login_token, username: @usuari.username } }, as: :json
    end

    assert_response 201
  end

  test "should show usuari" do
    get usuari_url(@usuari), as: :json
    assert_response :success
  end

  test "should update usuari" do
    patch usuari_url(@usuari), params: { usuari: { email: @usuari.email, image: @usuari.image, language: @usuari.language, location: @usuari.location, name: @usuari.name, password: 'secret', password_confirmation: 'secret', tipus: @usuari.tipus, login_token: @usuari.login_token, username: @usuari.username } }, as: :json
    assert_response 200
  end

  test "should destroy usuari" do
    assert_difference('Usuari.count', -1) do
      delete usuari_url(@usuari), as: :json
    end

    assert_response 204
  end
end
