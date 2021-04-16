require "test_helper"

class EventosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @evento = eventos(:two)
    @user = users(:two)
     host! 'api.example.com'
  end

  test "should get index" do
    get eventos_url, params: {token: @user.login_token, evento: @evento},  as: :json
    assert_response :success
  end

  def test_works  
      get comp_eventos_url params: {token: @user.login_token, id: @evento.id},  as: :json
     assert_response 200  
  end

  test "should create evento" do
    assert_difference('Evento.count') do
      post eventos_url, params: { token: @user.login_token, evento: { title: @evento.title, description: @evento.description , start_date: @evento.start_date, end_date: @evento.end_date, image: @evento.image , capacity: @evento.capacity , latitude: @evento.latitude, longitude:@evento.longitude, price: @evento.price, URL_page: nil, URL_share: nil, start_time: @evento.start_time, end_time: @evento.end_time } }, as: :json
    end
    assert_response 201
  end

  test "should show evento" do
    get eventos_url(@evento), params: {token: @user.login_token, id: @evento.id},  as: :json
    assert_response :success
  end

   test "should update evento" do
    put evento_url(@evento), params: { token: @user.login_token, evento: { title: @evento.title, description: @evento.description , start_date: @evento.start_date, end_date: @evento.end_date, image: @evento.image , capacity: @evento.capacity , latitude: @evento.latitude, longitude:@evento.longitude, price: @evento.price, URL_page: nil, URL_share: nil, start_time: @evento.start_time, end_time: @evento.end_time } }, as: :json
    assert_response 200
  end

  test "should destroy evento" do
    assert_difference('Evento.count', -1) do
      delete evento_url(@evento), params: {token: @user.login_token, id: @evento.id}, as: :json
    end
  end

end
