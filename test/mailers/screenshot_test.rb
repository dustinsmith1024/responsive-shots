require "test_helper"

class ScreenshotMailerTest < ActionMailer::TestCase
  
  test "the email sends with a valid message" do
    s = ScreenshotMailer.screenshot_email(Message.create({url: 'http://go.com', email: 'dd@gmail.com'}))
    assert s.deliver
    assert !ActionMailer::Base.deliveries.empty?
  end
end
