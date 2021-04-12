require "test_helper"

class EventosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @evento = eventos(:two)
  end

  test "should get index" do
    get eventos_url, as: :json
    assert_response :success
  end

  test "should create evento" do
    assert_difference('Evento.count') do
      post eventos_url, params: { evento: { title: @evento.title, description: @evento.description , date: @evento.date, image: @evento.image , capacity: @evento.capacity , location: @evento.location , price: @evento.price, URL_page: nil, URL_share: nil , end_time: @evento.end_time } }, as: :json
    end

    assert_response 201
  end

end
