ENV['RACK_ENV'] = 'test'

require_relative 'backend_helper'
require_relative './features/web_helper'

require 'capybara'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require 'pg'


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                   SimpleCov::Formatter::Console,
                                                               # Want a nice code coverage website? Uncomment this next line!
                                                               # SimpleCov::Formatter::HTMLFormatter
                                                               ])
SimpleCov.start


require_relative '../app'



Capybara.app = MakersBnb

RSpec.configure do |config|

  config.after(:each) do
    truncate_db
  end

end
