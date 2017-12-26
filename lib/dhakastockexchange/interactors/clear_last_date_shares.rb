require 'hanami/interactor'

class ClearLastDateShares
  include Hanami::Interactor

  def initialize(current_date_share_repository: CurrentDateShareRepository.new)
    @current_date_share_repository = current_date_share_repository
  end

  def call
    @current_date_share_repository.clear
  end
end