require "test_helper"

class MessageTest < ActiveSupport::TestCase
  fixtures :sizes

  def test_object_methods
    message = Message.new({ url: 'http://gmail.com', email: 'example@gmail.com' })
    [:email, :url, :token, :description, :error, :delivery_time, :queued, :prepare, :cleanup, :send].each do |method|
      assert_respond_to message, method
    end
  end

  def test_valid
    message = Message.new({ url: 'http://gmail.com', email: 'example@gmail.com' })
    assert message.valid?, "Can't create with valid params: #{message.errors.messages}"
  end

  def test_invalid_email
    message = Message.new({email: 'no-at-sign-gmail.com', url: 'http://go.com'})

    refute message.valid?, "Message was valid and shouldn't be!"
    refute_empty message.errors[:email], "Missing an error for emails!"
  end

  def test_invalid_without_email
    message = Message.new({url: 'http://go.com'})

    refute message.valid?, "Message was valid and shouldn't be!"
    refute_empty message.errors[:email], "Missing an error for emails!"
  end

  def test_invalid_without_url
    message = Message.new({email: 'h@gmail.com'})

    refute message.valid?, "Can't be valid without url"
    refute_empty message.errors[:url], "Missing error when without url"
  end

  def test_invalid_url
    message = Message.new({url: 'htp:/no.com', email: 'h@gmail.com'})

    refute message.valid?, "Can't be valid without url"
    refute_empty message.errors[:url], "Missing error when without url"
  end

  def test_prepare
    message = Message.create({ url: 'http://smith1024.com', email: 'dds1024+spam@gmail.com' })
    size = sizes(:desktop)
    size2 = sizes(:mobile)
    shot1 = message.screenshots.create({size_id: size.id})
    shot2 = message.screenshots.create({size_id: size2.id})

    message.prepare
    refute_nil shot1.file
    refute_nil shot2.file
    refute message.error

    message.cleanup
  end

  def test_deliver
    message = Message.create({ url: 'http://smith1024.com', email: 'dds1024+spam@gmail.com' })
    size2 = sizes(:mobile)
    shot1 = message.screenshots.create({size_id: size2.id})

    message.deliver
    refute_nil shot1.file
    refute message.error
    refute ActionMailer::Base.deliveries.empty?
    refute File.exists?(shot1.file)
  end
end
