# scrankychron.rb

require 'tumblr_client'

# Constants
SCRANKYCON = 'yves-lafrance.tumblr.com'
# SCRANKYCON = 'scrankycon.tumblr.com'

# Tumbl Parameters
$consumer_key        = ENV['CONSUMER_KEY']
$consumer_secret     = ENV['CONSUMER_SECRET']
$access_token        = ENV['ACCESS_TOKEN']
$access_token_secret = ENV['ACCESS_TOKEN_SECRET']

class ScrankyChron

  def call(env)
    response = Rack::Response.new

    case env['PATH_INFO']
    when "/upload_photo", "/upload_photo/"
      # tumblr_client gem configuration
      Tumblr.configure do |config|
        config.consumer_key       = $consumer_key
        config.consumer_secret    = $consumer_secret
        config.oauth_token        = $access_token
        config.oauth_token_secret = $access_token_secret
      end
  
      begin
        params = Rack::Multipart.parse_multipart(env)
        datafile = params["datafile"]
        pathtempfile = datafile[:tempfile].path

        begin
          # Upload photo
          client = Tumblr::Client.new
  
          code = client.photo(SCRANKYCON, { :data => [ pathtempfile ],
                                            :caption => params["caption"] }) 
          response.body = [ "Photo successfully uploaded on ScrankyCon Tumblr account", "\n\n" ]
#           response.body = [ "Photo successfully uploaded on ScrankyCon Tumblr account", "\n\n",
#                             (params.inspect.gsub! ", ", ",\n"), "\n\n",
#                             (datafile.inspect.gsub! ", ", ",\n"), "\n\n",
#                             code.inspect, "\n\n" ]
          response.status = 202

        rescue
          response.body = [ "Photo failed to upload for who knows what contrived reason :(" ]
          response.status = 400
        end

      rescue
        response.body = [ "Photo failed to upload because no file was selected" ]
        response.status = 400
      end

    else
      response.body = [ "Unknown command" ]
#       response.body = [ "Unknown command", "\n\n", 
#                         env.inspect, "\n\n"]
      response.status = 501
    end

    response.finish # return the generated triplet
  end
end

