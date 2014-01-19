require 'capybara/poltergeist'

class Screenshot < ActiveRecord::Base
  include Capybara::DSL
  belongs_to :message
  delegate :url, to: :message


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
