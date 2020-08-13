require_relative './database_start_script'

class User

  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @name = name
    @email = email
    @id = id
  end

  def self.add(name:, email:, password:)
    record = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{password}') RETURNING id, name, email").first
    user = User.new(id: record['id'], name: record['name'], email: record['email'])
  end

end
