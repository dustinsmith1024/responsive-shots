class Message < ActiveRecord::Base
	validates :url, presence: true, format: {:with => URI::regexp(%w(http https))}
	validates :email, presence: true, format: {:with => /@/}
end
