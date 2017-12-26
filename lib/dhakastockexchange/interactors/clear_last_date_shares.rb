require 'hanami/interactor'
require_relative './../constants/office'

class ClearLastDateShares
  include Hanami::Interactor
  include Office

  def initialize(current_date_share_repository: CurrentDateShareRepository.new)
    @current_date_share_repository = current_date_share_repository
  end

  def call
    if Office::OPEN == @office_hour_interactor.call.office_hour
      @current_date_share_repository.clear
    end
  end
end