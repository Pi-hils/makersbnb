require 'sinatra/base'
require 'rack-flash'
require_relative './models/database_start_script'
require_relative './models/space'
require_relative './models/request'
require_relative './models/user'

class MakersBnb < Sinatra::Base

  set :static, true
  enable :sessions, :method_override
  use Rack::Flash


  get '/login' do
    erb :login
  end

  post '/session' do
    p params
    User.authenticate(email: params['user_name'], password: params['user_password'])
    session[:user_id] = user.id
    redirect '/dashboard'
  end

  get '/dashboard' do
    p params
     @user = User.find(id: session[:user_id])
    erb :dashboard
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
   User.add(name: params[:name], email: params[:email], password: params[:password])
   p params
   redirect '/dashboard'
  end

  get '/hostings' do
    erb :your_hostings
  end

  get '/yourstays' do
    erb :your_stays
  end

  get '/:space_id/space_details' do
    @space = Spaces.find(params[:space_id])
    erb :space_details
  end

  get '/' do
    erb(:login) # Needs to be resolved to an actual route
  end

  get '/spaces/add' do
    erb :add_space
  end

  post '/spaces/:host_id/add' do
    p params
    Spaces.add(name: params[:space_name], price: params[:price], description: params[:description],
      availability_start: params[:availability_start], availability_end: params[:availability_end],
      host_id: params[:host_id])
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Spaces.all
    erb(:view_spaces)
  end


end
