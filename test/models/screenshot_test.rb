require "test_helper"

class ScreenshotTest < ActiveSupport::TestCase
  fixtures :sizes

  def test_object_methods
  	message = Message.create({ url: 'http://gmail.com', email: 'example@gmail.com' })
  	screenshot = message.screenshots.new({})
  	[:message, :url, :height, :width, :file].each do |method|
  		assert_respond_to screenshot, method
  	end
  end

  # TODO: This should probably be moved to integration test or totaly extracted from the model.
  def test_taking
    message = Message.create({ url: 'http://smith1024.com', email: 'dds1024+spam@gmail.com' })
    size2 = sizes(:mobile)
    screenshot = message.screenshots.new({size_id: size2.id})
    screenshot.take
    refute message.error
    screenshot.delete_file
  end

  def test_deleting
    message = Message.create({ url: 'http://smith1024.com', email: 'dds1024+spam@gmail.com' })
    size2 = sizes(:mobile)
    screenshot = message.screenshots.new({size_id: size2.id})
    screenshot.take
    assert File.exists?(screenshot.file)
    screenshot.delete_file
    refute File.exists?(screenshot.file)
  end

  def test_deleting_nil_file
    message = Message.create({ url: 'http://smith1024.com', email: 'dds1024+spam@gmail.com' })
    size2 = sizes(:mobile)
    screenshot = message.screenshots.new({size_id: size2.id})

    screenshot.delete_file
  end
end
