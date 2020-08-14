class Message

  attr_reader :id, :content, :published, :poster_id, :owner, :poster_name, :poster_email

  def initialize(id:, content:, published:, poster_id: )
    @id = id; @content = content; @published = DateTime.parse(published).strftime('%d/%m/%Y %k:%M:%S'); @poster_id = poster_id
    get_owner_details(poster_id)
  end

  def self.add(poster_id:, content:)
    message = DatabaseConnection.query("INSERT INTO message (content, poster_id) VALUES('#{content}','#{poster_id}') RETURNING *")
    message_wrapper(message).first
  end

  def self.message_wrapper(query_result)
    query_result.map { |message|
      Message.new(id: message['id'],
                  content: message['content'],
                  published: message['published'],
                  poster_id: message['poster_id'] )
    }
  end

  def get_owner_details(poster_id)
    owner = DatabaseConnection.query("SELECT users.id, users.name, users.email FROM users WHERE id = #{poster_id}").first
    @poster_name = owner['name']; @poster_email = owner['email']
  end

end
