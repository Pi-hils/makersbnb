require 'sinatra/base'
require 'rack-flash'
require_relative './models/database_start_script'
require_relative './models/space'

class MakersBnb < Sinatra::Base

  set :static, true
  enable :sessions, :method_override
  use Rack::Flash


  get '/' do
    erb :'login'
    # 'Welcome to MakersBnb'
  end

  get '/spaces' do
    erb :'view_spaces'
  end


  get '/spaces/new' do
    erb :'add_space'
  end

  post '/spaces/new' do
    erb :'add_space'
  end
  
end
