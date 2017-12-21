require 'hanami/interactor'

class AddShares
  include Hanami::Interactor

  def initialize(fetch_current_shares_interactor: FetchCurrentShares.new, add_share_interactor: AddShare.new)
    @fetch_current_shares_interactor = fetch_current_shares_interactor
    @add_share_interactor = add_share_interactor
  end

  def call
    @fetch_current_shares_interactor.call.shares.each do |share|
      @add_share_interactor.call(share)
    end
  end

end