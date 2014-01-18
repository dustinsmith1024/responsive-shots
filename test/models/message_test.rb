require "test_helper"

class MessageTest < ActiveSupport::TestCase
  
  def test_object_methods
    message = Message.new({ url: 'http://gmail.com', email: 'example@gmail.com' })
    [:email, :url, :token, :description, :error, :delivered].each do |method|
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
end
