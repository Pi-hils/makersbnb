require 'sinatra/base'
require 'rack-flash'
require_relative './models/database_start_script'
require_relative './models/space'

class MakersBnb < Sinatra::Base

  set :static, true
  enable :sessions, :method_override
  use Rack::Flash


  get '/login' do
    erb :'login'
  end

  post '/login' do
    redirect '/dashboard'
  end

  get '/dashboard' do
    erb :'dashboard'
  end


  get '/signup' do
    erb :'sign_up'
  end

  post '/signup' do
    redirect '/dashboard'
  end

  get '/hostings' do
    erb :'your_hostings'
  end

  get '/space_details' do
    erb :'space_details'
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
