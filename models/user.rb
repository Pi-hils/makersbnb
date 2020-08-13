require 'bcrypt'
require_relative './database_start_script'

class User

  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @name = name
    @email = email
    @id = id
  end

  def self.add(name:, email:, password:)
    authenticated_password = BCrypt::Password.create(password)
    user = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{authenticated_password}') RETURNING id, name, email")
    user_wrapper(user).first
  end

  def self.find(id:)
    user = DatabaseConnection.query("SELECT id, email, name FROM users WHERE id = #{id}")
   user_wrapper(user).first
  end

  def self.user_wrapper(query_result)
   query_result.map { |record| 
      User.new(id: record['id'], name: record['name'], email: record['email'])
    }
  end

  def self.authenticate(email:, password:)
    user = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")
    return unless user.any?
    return user_wrapper(user).first if password == user.first['password']
    return unless BCrypt::Password.new(user.first['password']) == password

    user_wrapper(user).first
  end

end

