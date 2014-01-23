class Size < ActiveRecord::Base
  has_many :screenshots
  scope :common, -> { where(primary: true).order(width: :desc) }
end
