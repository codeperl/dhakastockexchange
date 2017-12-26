require 'net/http'

module RealTimeApp
  class Broadcast
    def message(channel, content)
      message = {channel: channel, data: content, ext: {auth_token: 'secret'}}
      uri = URI.parse('http://localhost:8080/faye') # FIXME! ROMAN!
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(message: message.to_json)

      http.request(request)
    end
  end
end