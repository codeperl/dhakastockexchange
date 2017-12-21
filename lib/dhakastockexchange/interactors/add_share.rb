require 'hanami/interactor'

class AddShare
  include Hanami::Interactor

  expose :share

  def initialize(share_repository: ShareRepository.new)
    @share_repository = share_repository
  end

  def call(share)
    @share = @share_repository.create(share)
  end
end