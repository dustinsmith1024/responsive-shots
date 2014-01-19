require "test_helper"

class MessageDelivererTest < ActiveSupport::TestCase
  def test_perform
    message = Message.create({ url: 'http://smith1024.com', email: 'dds1024+spam@gmail.com' })
    shot1 = message.screenshots.create({height: 800, width: 1200})

    MessageDeliverer.perform(message.id)
    message.reload
    shot1.reload
    refute_nil shot1.file
    refute message.error
    refute ActionMailer::Base.deliveries.empty?
    refute File.exists?(shot1.file)
  end
end