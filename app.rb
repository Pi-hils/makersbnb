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

  get '/spaces/add' do
    p 'Hello'
    erb :'add_space'
  end

  post '/spaces/add' do
    p 'Hello World'
    Spaces.add(name: params[:space_name], price: params[:price], description: params[:description],
      availability_start: params[:availability_start], availability_end: params[:availability_end],
      host_id: params[:host_id])
      # needs to be removed as already created a route method GET for this and index doesn't exist
    # erb (:index)
  end

  get '/spaces' do
    @spaces = Spaces.all
     # there is no 'index.erb'..yet
    # erb(:index)
  end

end
