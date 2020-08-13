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
    user = User.authenticate(email: params['user_email'], password: params['user_password'])
    if !user || user == 'FAILED2' || user == 'FAILED3'
      flash[:notice] = 'Invalid information submitted. Login unsuccessful.'
    else
      session[:user_id] = user.id
      redirect '/dashboard'
    end
  end

  get '/dashboard' do
    p @user = User.find(id: session[:user_id])
    erb :dashboard
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    user = User.add(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/dashboard'
  end

  get '/your_hostings' do
    # @requests = Request.get_requests(params[:host_id])
    p @user = User.find(id: session[:user_id])
    @requests = Request.get_requests(host_id: session[:user_id])
    erb :your_hostings
  end

  get '/your_stays' do
    p @user = User.find(id: session[:user_id])
    @stays = Request.get_stays(guest_id: session[:user_id])
    erb :your_stays
  end

  get '/:space_id/space_details' do
    @space = Spaces.find(params[:space_id])
    p @user = User.find(id: session[:user_id])
    erb :space_details
  end

  get '/' do
    erb(:login)
  end

  get '/spaces/new' do
    p @user = User.find(id: session[:user_id])
    erb :add_space
  end

  post '/spaces/:host_id/new' do
    p params
    Spaces.add(name: params[:space_name], price: params[:price], description: params[:description],
      availability_start: params[:availability_start], availability_end: params[:availability_end],
      host_id: params[:host_id])
    redirect '/spaces'
  end

  get '/spaces' do
    p @user = User.find(id: session[:user_id])
    @spaces = Spaces.all
    erb(:view_spaces)
  end

  post '/:guest_id/:space_id/request/new' do
    p params
    Request.add(space_id: params[:space_id], guest_id: params[:guest_id], start_date: params[:start_date], end_date: params[:end_date])
    redirect '/your_stays'
  end

end
