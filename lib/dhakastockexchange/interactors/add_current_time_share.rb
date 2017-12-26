require 'hanami/interactor'

class AddCurrentTimeShare
  include Hanami::Interactor

  expose :current_time_share

  def initialize(current_time_share_repository: CurrentTimeShareRepository.new)
    @current_time_share_repository = current_time_share_repository
  end

  def call(share)
    @current_time_share = @current_time_share_repository.create(share)
  end
end