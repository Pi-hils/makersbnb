require 'sinatra/base'
require 'rack-flash'
require_relative './models/database_start_script'
require_relative './models/space'
require_relative './models/request'

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

  get '/your_hostings' do
    # @requests = Request.get_requests(params[:host_id])
    erb :your_hostings
  end

#need more backend development before completing below path
  get '/your_stays' do
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
    erb :'add_space'
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

  post '/:guest_id/:space_id/request/new' do
    p params
    Request.add(space_id: params[:space_id], guest_id: params[:guest_id], start_date: params[:start_date], end_date: params[:end_date])
    redirect '/your_stays'
  end

end
