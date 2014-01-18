class Screenshot < ActiveRecord::Base
	belongs_to :message
	delegate :url, to: :message
end
