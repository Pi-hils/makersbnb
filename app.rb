require 'sinatra/base'

class MakersBnb < Sinatra::Base
  get '/' do
    'Welcome to MakersBnb'
  end

  run! if app_file == $0
end
