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
    options = {}
    options[:js_errors]=false

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, options)
    end

    Capybara.default_driver = :poltergeist
    
    self.file = file_name
    begin
      visit(url)
      page.driver.resize_window(width, height)
      page.driver.render(file, full: true)
      self.save
    rescue => e
      puts e
      message.error = true
      #ScreenshotMailer.screenshot_error_email(self).deliver
    end # End rescue block
    
    # TODO: Could possibly queue this too
    #ScreenshotMailer.screenshot_email(self).deliver unless self.error
    #self.histories.create(email: self.email)
    message.delivered = Time.now
    self.save!
    message.save!
    #files.each do |file|
    #  File.delete(file)
    #end
  end

  def delete_file
    File.delete(file)
  end

  def run
    # These might be definable somewhere else?
    self.error = false
    Capybara.app_host = url
    options = {}
    options[:js_errors]=false
    Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, options)
    end
    Capybara.default_driver = :poltergeist
    begin
      visit(url)
      files = []
      sizes.each_with_index do |size, index|
        if size.height && size.width
          file_name = "screenshot_#{id}_#{index}.png"
          page.driver.resize_window(size.width, size.height)
          page.driver.render(file_name, full: true)
          size.file = file_name
          files << size.file
          size.save
        end
      end
    rescue => e
      puts e
      self.error = true
      ScreenshotMailer.screenshot_error_email(self).deliver
    end # End rescue block
    
    # TODO: Could possibly queue this too
    ScreenshotMailer.screenshot_email(self).deliver unless self.error
    self.histories.create(email: self.email)
    self.delivered = Time.now
    self.save!
    files.each do |file|
      File.delete(file)
    end
  end
end
