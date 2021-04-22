require "test_helper"

class EntradaUsuariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entrada_usuario = entrada_usuarios(:one)
    @evento = eventos(:two)
    @user = users(:two)
    host! 'api.example.com'
  end

  test "should get index" do
    get entrada_usuarios_url, params: {token: @user.login_token, evento: @evento.id},  as: :json
    assert_response :success
  end

  test "should create entrada_usuario" do
    assert_difference('EntradaUsuario.count') do
      post entrada_usuarios_url, params: {token: @user.login_token, entrada_usuario: { event_id: @entrada_usuario.event_id} }, as: :json
    end

    assert_response 201
  end

  test "should show entrada_usuario" do
    get entrada_usuario_url(@entrada_usuario), as: :json
    assert_response :success
  end

  test "should update entrada_usuario" do
    patch entrada_usuario_url(@entrada_usuario), params: { entrada_usuario: { code: @entrada_usuario.code, event_id: @entrada_usuario.event_id, user_id: @entrada_usuario.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy entrada_usuario" do
    assert_difference('EntradaUsuario.count', -1) do
      delete entrada_usuario_url(@entrada_usuario), as: :json
    end

    assert_response 204
  end
end
