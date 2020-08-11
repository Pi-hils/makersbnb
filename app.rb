require 'sinatra/base'

class MakersBnb < Sinatra::Base
  get '/' do
    'Welcome to MakersBnb'
  end

  get '/spaces' do
    erb :'spaces/view_spaces'
  end

  get '/spaces/new' do
    erb :'spaces/new/add_space'
  end

  post '/spaces/new' do
    erb :'spaces/new/add_space'
  end

  run! if app_file == $0
end
