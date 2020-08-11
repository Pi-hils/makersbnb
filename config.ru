require_relative "./app"

use Rack::Static, :urls => ['/stylesheets', '/images'], :root => 'public'
use Rack::MethodOverride


run MakersBnb
