require 'hanami/interactor'
require_relative './../pubsub/realtime_app/broadcast'

class PublishSharesUpdates
  include Hanami::Interactor
  include RealTimeApp

  def initialize(broadcast_service: Broadcast.new)
    @broadcast_service = broadcast_service
  end

  def call(channel, content)
    @broadcast_service.message(channel, content)
  end
end