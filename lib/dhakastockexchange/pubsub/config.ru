require 'faye'
require_relative './realtime_app/realtime_app'

Faye::WebSocket.load_adapter('thin')
faye_server = Faye::RackAdapter.new(mount: '/faye', :timeout => 30) # FIXME! ROMAN!
faye_server.add_extension(RealTimeApp::ServerAuth.new)
run faye_server