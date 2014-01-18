class Message < ActiveRecord::Base
	has_many :screenshots
	validates :url, presence: true, format: {:with => URI::regexp(%w(http https))}
	validates :email, presence: true, format: {:with => /@/}

  def deliver
    screenshots.each do |screenshot|
      screenshot.take
    end
    puts self.inspect
    ScreenshotMailer.screenshot_email(self).deliver unless self.error
  end
end
