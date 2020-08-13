require_relative './spec_helper'

def database
  PG.connect(dbname: 'makersbnb_test', user: 'postgres', password: '')
end

def generate_example_master
  database.query("INSERT INTO users (name, email, password) VALUES('master', 'master', 'master');")
end

def generate_example_user
  database.query("INSERT INTO users (name, email, password) VALUES('test', 'test@test.com', 'passw0rd');")
end

def generate_example_space
  database.query("INSERT into spaces (name, price, description, availability_start, availability_end, host_id) VALUES('test1','250.00','test','#{Date.parse('11/08/2020')}','#{Date.parse('18/08/2020')}', '1');")
  database.query("INSERT into spaces (name, price, description, availability_start, availability_end, host_id) VALUES('test2','350.00','test','#{Date.parse('11/08/2020')}','#{Date.parse('18/08/2020')}', '1');")
  database.query("INSERT into spaces (name, price, description, availability_start, availability_end, host_id) VALUES('test3','450.00','test','#{Date.parse('11/08/2020')}','#{Date.parse('18/08/2020')}', '1');")
end

def generate_more_spaces
  database.query("INSERT into spaces (name, price, description, availability_start, availability_end, host_id) VALUES('test4','550.00','test','#{Date.parse('13/08/2020')}','#{Date.parse('20/08/2020')}', '2');")
  database.query("INSERT into spaces (name, price, description, availability_start, availability_end, host_id) VALUES('test5','650.00','test','#{Date.parse('13/08/2020')}','#{Date.parse('20/08/2020')}', '2');")
end

def generate_example_threads

end

def generate_all_examples

end

def generate_examples_wait
end

def db_data(params = '*', id:, table:)
  database.query("SELECT #{params} FROM #{table} WHERE id=#{id}")
end

def truncate_db
  return unless ENV['RACK_ENV'] == 'test'

  database.query('TRUNCATE user_messages, message, requests, spaces, users RESTART IDENTITY')
end
