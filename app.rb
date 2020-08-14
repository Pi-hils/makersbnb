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

  def find_user_and_validate
    redirect '/login' unless session[:user_id]
    @user = User.find(id: session[:user_id])
    redirect '/login' unless @user
  end


  get '/login' do
    erb :login
  end

  post '/session' do
    user = User.authenticate(email: params['user_email'], password: params['user_password'])
    if !user || user == 'FAILED1' || user == 'FAILED2' || user == 'FAILED3'
      flash[:notice] = 'Please check your login credentials'
      redirect '/login'
    else
      session[:user_id] = user.id
      redirect '/dashboard'
    end
  end

  get '/dashboard' do
    find_user_and_validate
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
    find_user_and_validate
    @requests = Request.get_requests(host_id: session[:user_id])
    erb :your_hostings
  end

  get '/your_stays' do
    find_user_and_validate
    @stays = Request.get_stays(guest_id: session[:user_id])
    erb :your_stays
  end

  get '/:space_id/space_details' do
    @space = Spaces.find(params[:space_id])
    find_user_and_validate
    erb :space_details
  end

  get '/' do
    erb(:login)
  end

  get '/spaces/new' do
    find_user_and_validate
    erb :add_space
  end

  post '/spaces/:host_id/new' do
    Spaces.add(name: params[:space_name], price: params[:price], description: params[:description],
      availability_start: params[:availability_start], availability_end: params[:availability_end],
      host_id: params[:host_id])
    redirect '/spaces'
  end

  get '/spaces' do
    find_user_and_validate
    @spaces = Spaces.all
    erb(:view_spaces)
  end

  post '/:guest_id/:space_id/request/new' do
    request = Request.add(space_id: params[:space_id], guest_id: params[:guest_id], start_date: params[:start_date], end_date: params[:end_date])
    if !request
      flash[:notice] = 'This space is not available for those dates, please try again'
      redirect "/#{params[:space_id]}/space_details"
    else
      redirect '/your_stays'
    end
  end

  patch '/request/accept/:request_id' do
    find_user_and_validate
    Request.accept(id: params[:request_id])
    redirect '/your_hostings'
  end

  patch '/request/decline/:request_id' do
    find_user_and_validate
    Request.decline(id: params[:request_id])
    redirect '/your_hostings'
  end

  patch '/request/undo/:request_id' do
    find_user_and_validate
    Request.undo(id: params[:request_id])
    redirect '/your_hostings'
  end

  get '/session/destroy' do
    session.clear
    flash[:notice] = 'You have successfully signed out'
    redirect '/login'
  end

  get '/about' do
    erb :about_us
  end 
  
  delete '/request/cancel/:request_id' do
    Request.cancel(id: params[:request_id])
    redirect '/your_stays'
  end

end
