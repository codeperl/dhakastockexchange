require 'hanami/interactor'

class AddShare
  include Hanami::Interactor

  expose :share

  def initialize(shareRepository: ShareRepository.new)
    @shareRepository = shareRepository
  end

  def call(share)
    @share = @shareRepository.create(share)
  end
end