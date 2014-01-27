require "test_helper"

class MessagesControllerTest < ActionController::TestCase
  fixtures :sizes
  
  before do
    @message = messages(:one)
  end

  def test_index
    # Must send an email to get a list of messages
    Message.create({email: 'test@gmail.com', url: 'http://hi.com'})
    get :index, email: 'test@gmail.com'
    assert_response :success
    refute_empty assigns(:messages)
  end

  def test_index_failure
    get :index
    assert_response :missing
  end

  # Requires a fixture setup because it builds a messsage.screenshot
  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference(['Message.count', 'Screenshot.count']) do
      post :create, {
        message: { description: 'sup', url: 'http://email.com', email: 'h@gmail.com'},
        sizes: { sizes(:desktop).id => true}}
    end

    assert_redirected_to message_path(assigns(:message))
  end

  def test_create_fail
    assert_no_difference(['Message.count', 'Screenshot.count']) do
      post :create, {
        message: { description: 'sup'},
        sizes: { '2222' => true}}
    end
  end


  def test_no_screenshots_added
    assert_no_difference('Screenshot.count') do
      post :create, {
        message: { description: 'sup', url: 'http://email.com', email: 'h@gmail.com'}}
    end
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
    put :update, id: @message, message: { url: 'http://one.com', 
      email: 'h@gmail.com',
      screenshots_attributes: [{size_id: '1', id: '1'}] }
    assert_redirected_to message_path(assigns(:message))
  end

  def test_wont_update_restricted_fields
    put :update, id: @message, message: { delivery_time: Time.now, token: '123', error: true, url: 'http://one.com', email: 'h@gmail.com' }
    new_message = assigns(:message)

    assert_equal('http://one.com', new_message.url)
    assert_equal(@message.delivery_time, new_message.delivery_time)
    assert_equal(@message.error, new_message.error)
    assert_equal(@message.token, new_message.token)

    assert_redirected_to message_path(assigns(:message))
  end
end
