require 'hanami/interactor'

class AddCurrentDateShare
  include Hanami::Interactor

  expose :current_date_share

  def initialize(current_date_share_repository: CurrentDateShareRepository.new)
    @current_date_share_repository = current_date_share_repository
  end

  def call(share)
    @current_date_share = @current_date_share_repository.create(share)
  end
end