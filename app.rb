require 'sinatra/base'
require_relative './models/database_start_script'

class MakersBnb < Sinatra::Base

  get '/' do
    'Welcome to MakersBnb'
  end

end
