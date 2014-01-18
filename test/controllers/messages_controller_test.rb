require "test_helper"

class MessagesControllerTest < ActionController::TestCase

  before do
    @message = messages(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Message.count') do
      post :create, message: { description: 'sup', url: 'http://email.com', email: 'h@gmail.com' } # investigate: minitest doesnt like a blank message? 
    end

    assert_redirected_to message_path(assigns(:message))
  end

  def test_show
    get :show, id: @message
    assert_response :success
  end

  def test_edit
    get :edit, id: @message
    assert_response :success
  end

  def test_update
    put :update, id: @message, message: { url: 'http://one.com', email: 'h@gmail.com' }
    assert_redirected_to message_path(assigns(:message))
  end

  def test_wont_update_restricted_fields
    put :update, id: @message, message: { delivered: true, token: '123', error: true, url: 'http://one.com', email: 'h@gmail.com' }
    new_message = assigns(:message)

    assert_equal('http://one.com', new_message.url)
    assert_equal(@message.delivered, new_message.delivered)
    assert_equal(@message.error, new_message.error)
    assert_equal(@message.token, new_message.token)

    assert_redirected_to message_path(assigns(:message))
  end

  def test_destroy
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end
end
