require_relative './spec_helper'

def database
  PG.connect(dbname: 'makersbnb_test', user: 'postgres', password: '')
end

def generate_example_master
  database.query("INSERT INTO users (name, email, password) VALUES('master', 'master', 'master');")
end

def generate_example_peeps

end

def generate_example_user_peeps

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

  database.query('TRUNCATE user_peeps, threads, users, peeps RESTART IDENTITY')
end



