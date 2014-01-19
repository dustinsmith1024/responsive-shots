class MessageDeliverer < Object

  def self.perform(message_id)
    Message.find(message_id).deliver
  end
end