require "test_helper"

class ValoraciosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valoracio = valoracios(:one)
  end

  test "should get index" do
    get valoracios_url, as: :json
    assert_response :success
  end

  test "should create valoracio" do
    assert_difference('Valoracio.count') do
      post valoracios_url, params: { valoracio: { rating: @valoracio.rating, text: @valoracio.text } }, as: :json
    end

    assert_response 201
  end

  test "should show valoracio" do
    get valoracio_url(@valoracio), as: :json
    assert_response :success
  end

  test "should update valoracio" do
    patch valoracio_url(@valoracio), params: { valoracio: { rating: @valoracio.rating, text: @valoracio.text } }, as: :json
    assert_response 200
  end

  test "should destroy valoracio" do
    assert_difference('Valoracio.count', -1) do
      delete valoracio_url(@valoracio), as: :json
    end

    assert_response 204
  end
end
