class MessageForm
  include ActiveModel::Model
  attr_accessor :email, :url, :sizes

  validates :email, presence: true
  validates :url, presence: true

  def initialize(message_params={})
    #@message_model = Message.new(message_params)
    email = message_params[:email]
    url = message_params[:url]
    sizes = message_params[:sizes]
    build_message
  end

  def screenshots
    unless id
      [@message.screenshots.build(size_id: Size.common.first.id)]
    end
  end

  def persisted?
    false
  end

  def id
    nil
  end

  def build_message
    @message = Message.new(url: url, email: email)
    sizes && sizes.keys.each do |size|
      @message.screenshots.new(size_id: size) if Size.exists?(size)
    end
  end


  def save
    if valid?
      persist
    else
      false
    end
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Message")
  end
end
