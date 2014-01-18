class ScreenshotMailer < ActionMailer::Base
  default :from => "notifications@smith1024.com"
 
  def screenshot_email(message)
  	@message = message
    #screenshot.sizes.each_with_index do |size, index|
   # 	attachments["shot_#{index}.png"] = File.read(size.file)
   # end
    mail(:to => @message.email,
    	 :subject => "Your screenshot for #{@url}")
  end

  def screenshot_error_email(screenshot)
    @screenshot = screenshot
    
    mail(:to => screenshot.email,
    	 :subject => "Errors Taking Your screenshot for #{screenshot.url}")
  end
end
