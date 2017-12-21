require 'hanami/interactor'

class AddShares
  include Hanami::Interactor

  def initialize(fetchCurrentSharesInteractor: FetchCurrentShares.new, addShareInteractor: AddShare.new)
    @fetchCurrentSharesInteractor = fetchCurrentSharesInteractor
    @addShareInteractor = addShareInteractor
  end

  def call
    @fetchCurrentSharesInteractor.call.shares.each do |share|
      @addShareInteractor.call(share)
    end
  end

end