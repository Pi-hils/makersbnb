class UserMessages

  def self.add(thread_id:, message_id:, user_id:)
    DatabaseConnection.query("INSERT INTO user_messages (thread_id, message_id, user_id) VALUES('#{thread_id}','#{message_id}','#{user_id}')")
  end

end
