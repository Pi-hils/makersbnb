require 'sinatra/base'
require 'rack-flash'
require_relative './models/database_start_script'
require_relative './models/space'
<<<<<<< HEAD
require_relative './models/user'
=======
require_relative './models/request'
>>>>>>> d10271eefb91a4ad79b1be46cf445c7fce989613

class MakersBnb < Sinatra::Base

  set :static, true
  enable :sessions, :method_override
  use Rack::Flash



  get '/login' do
    erb :login
  end

  post '/login' do
    redirect '/dashboard'
  end

  get '/dashboard' do
    erb :dashboard
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    redirect '/dashboard'
  end

  get '/hostings' do
    erb :your_hostings
  end

  get '/yourstays' do
    erb :'your_stays'
  end

  get '/space_details' do
    erb :space_details
  end

  get '/' do
    erb(:login) # Needs to be resolved to an actual route
  end

  get '/spaces/add' do
    erb :'add_space'
  end

  get '/spaces/new' do
    erb(:add_space)
  end

  post '/spaces/:host_id/new' do
    p params
    Spaces.add(name: params[:space_name], price: params[:price], description: params[:description],
      availability_start: params[:availability_start], availability_end: params[:availability_end],
      host_id: params[:host_id])
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Spaces.all
<<<<<<< HEAD
    erb :view_spaces
=======
    erb(:view_spaces)
>>>>>>> d10271eefb91a4ad79b1be46cf445c7fce989613
  end

  
end
