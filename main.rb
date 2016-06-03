# main.rb

## class MyApp
##   def call(env)
##     [200, {"Content-Type" => "text/html"}, ["Hello Rack Participants from across the globe"]]
##   end
## end

class HelloWorldApp
  def call(env)
#   env['HTTP_ACCEPT'] = 'application/json'
    response = Rack::Response.new
#   response.write ['Hello World (write)']
#     if env['PATH_INFO'] == "/cool/vanilla"
#       response.body = [env.inspect]
#     else
#       response.body = ['Hello World']
#     end

    case env['PATH_INFO']
    when "/"
      response.body = [env.inspect]
    when "/cool", "/cool/"
      response.body = ["Do cool stuff"]
    when "/cool/vanilla", "/cool/vanilla/"
      response.body = ["Do vanilly cool stuff"]
    when "/cool/chocolate", "/cool/chocolate/"
      response.body = ["Do chocolaty cool stuff"]
    else
      response.body = ["Do not so cool stuff"]
    end

    response['X-Custom-Header'] = 'foo'
    response.set_cookie 'bar', 'baz'
    response.status = 202

    response.finish # return the generated triplet
  end
end

# require 'rack'

# app = Rack::Builder.new do 
#   run HelloWorldApp
# end
# 
# Rack::Server.start :app => app
# 

# class EnsureJsonResponse
#   def initialize(app)
#     @app = app
#   end
# 
#   # Set the 'Accept' header to 'application/json' no matter what.
#   # Hopefully the next middleware respects the accept header :)
#   def call(env)
#     env['HTTP_ACCEPT'] = 'application/json'
#     @app.call env
#   end
# end
# 
# class Timer
#   def initialize(app)
#     @app = app
#   end
# 
#   def call(env)
#     before = Time.now
#     status, headers, body = @app.call env
# 
#     headers['X-Timing'] = (Time.now - before).to_i.to_s
# 
#     [status, headers, body]
#   end
# end
# 
# class MyRackMiddleware
#   def initialize(appl)
#     @appl = appl
#   end
#   def call(env)
#     status, headers, body = @appl.call(env) # we now call the inner application
#   end
# end
# 
# class HelloWorldApp
#   def self.call(env)
#     response = Rack::Response.new
# #   response.write 'Hello World (write)' # write some content to the body
#     response.body = ['Hello World (body reloadinger)'] # or set it directly
#     response['X-Custom-Header'] = 'foo'
#     response.set_cookie 'bar', 'baz'
#     response.status = 202
# 
#     response.finish # return the generated triplet
#   end
# end
# 
# app = Rack::Builder.new do 
# # use Timer # put the timer at the top so it captures everything below it
# # use EnsureJsonResponse
#   run HelloWorldApp
# end
# 
# Rack::Server.start :app => app

# # this returns an app that responds to call cascading down the list of 
# # middlewares. Technically there is no difference between "use" and
# # "run". "run" is just there to illustrate that it's the end of the 
# # chain and it does the work.
# app = Rack::Builder.new do 
#   use Rack::Etag            # Add an ETag
#   use Rack::ConditionalGet  # Support Caching
#   use Rack::Deflator        # GZip
#   run HelloWorldApp         # Say Hello
# end
# 
# Rack::Server.start :app => app
# 
# class HelloWorldApp
#   def self.call(env)
#     parser = ParamsParser.new self
#     env = parser.call env
#     # env['params'] is now set to a hash for all the input paramters
# 
#     [200, {}, [env['params'].inspect]] 
#   end
# end

# class Middleware
#   def initialize(app)
#     @app = app
#   end
# 
#   # This is a "null" middlware because it simply calls the next one.
#   # We can manipulate the input before calling the next middleware
#   # or manipulate the response before returning up the chain.
#   def call(env)
#     @app.call env
#   end
# end
# 
# class ParamsParser
#   def initialize(app)
#     @app = app
#   end
# 
#   def call(env)
#     request = Rack::Request.new env
#     env['params'] = request.params
# #   @app.call env
#   end
# end
# 
# class HelloWorldApp
#   def self.call(env)
#     parser = ParamsParser.new self
#     env = parser.call env
#     # env['params'] is now set to a hash for all the input paramters
# 
#     [200, {}, [env['params'].inspect]] 
#   end
# end

# class HelloWorldApp
#   def self.call(env)
#     response = Rack::Response.new
# #   response.write 'Hello World (write)' # write some content to the body
#     response.body = ['Hello World (body)'] # or set it directly
#     response['X-Custom-Header'] = 'foo'
#     response.set_cookie 'bar', 'baz'
#     response.status = 202
# 
#     response.finish # return the generated triplet
#   end
# end

# class HelloWorldApp
#   def self.call(env)
#     request = Rack::Request.new env
#     request.params # contains the union of GET and POST params
#     request.xhr?   # requested with AJAX
# #   require.body   # the incoming request IO stream
#     request.body   # the incoming request IO stream
# 
#     if request.params['message']
#       [200, {}, [request.params['message']]]
#     else
#       [200, {}, ['Say something to me!']]
#     end
#   end
# end

# Rack::Server.start :app => HelloWorldApp

# # hello_world.rb
# require 'rack'
# #require 'rack/server'
# 
# class HelloWorld
#   def response
#     [200, {}, ['Hello World']]
#   end
# end
# 
# class HelloWorldApp
#   def self.call(env)
#     [200, {}, [env.inspect]]
# #   [200, {}, ["Hello World. You said: #{env['QUERY_STRING']}"]]
# #   HelloWorld.new.response
#   end
# end
# 
# Rack::Server.start :app => HelloWorldApp

# # myapp.rb
# require 'sinatra'
# 
# get '/' do
#   'Hello worlds!'
# end




# # uploadPhoto.rb
# require 'rubygems'
# require 'tumblr_client'
# 
# # Constants
# SCRANKYCON = 'yves-lafrance.tumblr.com'
# # SCRANKYCON = 'scrankycon.tumblr.com'
# 
# class ScrankyChron
# 
#   def run
#     # Parameters
#     consumer_key        = 'yC8Mm5Fc95RcLF1LpxD0dmp4M0YDRUi0VINnXO1d98wlOwB9Rr'
#     consumer_secret     = '0fYscuYOjErNB2FCyhEdcWH61DErYgIzNkzzwFQeB1J5MI3T86'
#     access_token        = 'tjIOv2x4HhgOxhgL5j9GIQU8YQqwxqAT237POwpkQxJjWIaQpm'
#     access_token_secret = 'ME1sdcJjfevBp4kuvoqYOViGBeIh0VIkhf4nmatQxy0uAvHbK2'
# 
#     imageurl = ARGV[0]
#     caption = ARGV[1]
# 
#     # tumblr_client gem configuration
#     Tumblr.configure do |config|
#       config.consumer_key       = consumer_key
#       config.consumer_secret    = consumer_secret
#       config.oauth_token        = access_token
#       config.oauth_token_secret = access_token_secret
#     end
# 
#     client = Tumblr::Client.new
# 
#     # Upload photo
#     client.photo(SCRANKYCON, { :data => imageurl, :caption => caption }) 
# 
#     true
#   end
# 
# end
# 
# ScrankyChron.new.run
