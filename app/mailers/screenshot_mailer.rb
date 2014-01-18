class ScreenshotMailer < ActionMailer::Base
  default :from => "notifications@smith1024.com"
 
  def screenshot_email(message)
    @message = message
    message.screenshots.each do |screenshot, index|
      attachments[screenshot.file] = File.read(screenshot.file)
    end
    mail(:to => @message.email,
       :subject => "Your screenshot for #{@url}")
  end

  def screenshot_error_email(screenshot)
    @screenshot = screenshot
    
    mail(:to => screenshot.email,
       :subject => "Errors Taking Your screenshot for #{screenshot.url}")
  end
end
