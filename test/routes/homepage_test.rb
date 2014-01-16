require "test_helper"

class HomepageRouteTest < ActionDispatch::IntegrationTest
  def test_messages
  	# TODO: Would like to test root_path goes to controller messages#index but seems like this is the wrong way
    assert_generates '/messages', :controller => "messages", :action => "index"
  end
end