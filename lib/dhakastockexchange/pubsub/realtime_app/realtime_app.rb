module RealTimeApp

  class ServerAuth
    def incoming(message, callback)
      if message['channel'] !~ %r{^/meta}
        if (!message['ext']) || (message['ext']['auth_token'] != 'secret')
          message['error'] = 'Invalid authentication token'
        end
      end
      callback.call(message)
    end

    def outgoing(message, callback)
      if message['ext'] &&  message['ext']['auth_token']
        message['ext'] = {}
      end
      callback.call(message)
    end
  end

end