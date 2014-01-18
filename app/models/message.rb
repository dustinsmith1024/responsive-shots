class Message < ActiveRecord::Base
	has_many :screenshots
	validates :url, presence: true, format: {:with => URI::regexp(%w(http https))}
	validates :email, presence: true, format: {:with => /@/}
end
