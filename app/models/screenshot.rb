require 'capybara/poltergeist'

class Screenshot < ActiveRecord::Base
  include Capybara::DSL
  belongs_to :message
  belongs_to :size

  validates :size_id, presence: true
  
  delegate :url, to: :message
  delegate :height, to: :size
  delegate :width, to: :size

  def file_name
    "message_#{message.id}_screenshot_#{id}.png"
  end

  def take
    Capybara.app_host = url
    self.file = file_name
    
    begin
      visit(url)
      page.driver.resize_window(width, height)
      page.driver.render(file, full: true)
    rescue => e
      # TODO: Log appropriately and send error email
      puts e
      message.error = true
    end
    
    self.save
    message.save
  end

  def delete_file
    File.delete(file) if file
  end
end
