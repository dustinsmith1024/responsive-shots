class Message < ActiveRecord::Base
	has_many :screenshots
  accepts_nested_attributes_for :screenshots
	validates :url, presence: true, format: {:with => URI::regexp(%w(http https))}
	validates :email, presence: true, format: {:with => /@/}

  before_create :save_token

  def prepare
    screenshots.each do |screenshot|
      screenshot.take
    end
  end

  def cleanup
    screenshots.each do |screenshot|
      screenshot.delete_file
    end
  end

  def deliver
    prepare
    ScreenshotMailer.screenshot_email(self).deliver unless self.error
    cleanup
    self.queued = false
    self.delivery_time = Time.now
    self.save!
  end

  def size_ids
    screenshots.collect(&:size_id)
  end

  def has_screenshot_with_size?(size_id)
    size_ids.include? size_id
  end

  private

    # TODO: Use this as the ID in urls for a little more privacy
    def save_token
      self.token = SecureRandom.uuid unless self.token
    end
end
