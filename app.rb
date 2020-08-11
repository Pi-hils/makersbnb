require 'sinatra/base'
require 'rack-flash'
require_relative './models/database_start_script'
require_relative './models/space'

class MakersBnb < Sinatra::Base

  set :static, true
  enable :sessions, :method_override
  use Rack::Flash


  get '/' do
    'Welcome to MakersBnb'
    erb(:index)
  end

  post '/spaces/add' do
    Spaces.add(name: params[:space_name], price: params[:price], description: params[:description],
      availability_start: params[:availability_start], availability_end: params[:availability_end],
      host_id: params[:host_id])
    erb(:index)
  end

  get '/spaces' do
    @spaces = Spaces.all
    erb(:index)
  end


end
