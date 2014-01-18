require "test_helper"

class ScreenshotTest < ActiveSupport::TestCase
  def test_object_methods
  	message = Message.create({ url: 'http://gmail.com', email: 'example@gmail.com' })
  	screenshot = message.screenshots.new({})
  	[:message, :url, :height, :width, :file].each do |method|
  		assert_respond_to screenshot, method
  	end
  end
end
