require "test_helper"

class SizeTest < ActiveSupport::TestCase
  def test_object_methods
    message = Size.new({ icon: 'desktop', height: 300, width: 300 })
    [:slug, :display, :icon, :primary, :height, :width].each do |method|
      assert_respond_to message, method
    end
  end
end
