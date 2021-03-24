require "test_helper"

class EventosControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get eventos_create_url
    assert_response :success
  end
end
