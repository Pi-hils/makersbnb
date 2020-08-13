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
    record = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{authenticated_password}') RETURNING id, name, email").first
    user = User.new(id: record['id'], name: record['name'], email: record['email'])
  end

  def find(name)
    record = DatabaseConnection.query("SELECT name, email FROM users WHERE name ='#{name}'")
    first_row = record.first
    first_row.map do |k,v|
      v
    end
  end

end
