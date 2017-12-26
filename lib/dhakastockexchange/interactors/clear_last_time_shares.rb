require 'hanami/interactor'

class ClearLastTimeShares
  include Hanami::Interactor

  def initialize(current_time_share_repository: CurrentTimeShareRepository.new)
    @current_time_share_repository = current_time_share_repository
  end

  def call
    @current_time_share_repository.clear
  end
end