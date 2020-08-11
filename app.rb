require 'sinatra/base'
require_relative './models/database_start_script'

class MakersBnb < Sinatra::Base

  set :static, true
  enable :sessions, :method_override
  use Rack::Flash


  get '/' do
    'Welcome to MakersBnb'
  end

end
