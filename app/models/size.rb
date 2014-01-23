class Size < ActiveRecord::Base
  scope :common, -> { where(primary: true).order(width: :desc) }
end
