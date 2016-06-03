# config.ru
# require './main'
# require './myrackmiddleware'
require './scrankychron'

use Rack::Reloader
# use MyRackMiddleware
# run MyApp.new
# run HelloWorldApp.new
run ScrankyChron.new

