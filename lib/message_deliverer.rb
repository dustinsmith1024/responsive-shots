class MessageDeliverer < Object
  @queue = :messages

  def self.perform(message_id)
    Message.find(message_id).deliver
  end
end