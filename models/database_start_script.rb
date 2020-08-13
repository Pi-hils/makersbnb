require_relative './database_connection'


if ENV['RACK_ENV'] == 'test'
  p 'Starting test database..'
  DatabaseConnection.setup('makersbnb_test')
else
  p 'Starting main database..'
  DatabaseConnection.setup('makersbnb_production')
end
