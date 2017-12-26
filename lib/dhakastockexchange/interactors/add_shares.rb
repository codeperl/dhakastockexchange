require 'hanami/interactor'

class AddShares
  include Hanami::Interactor

  def initialize(fetch_current_shares_interactor: FetchCurrentShares.new,
                 clear_last_time_shares_interactor: ClearLastTimeShares.new,
                 add_share_interactor: AddShare.new,
                 add_current_date_share_interactor: AddCurrentDateShare.new,
                 add_current_time_share_interactor: AddCurrentTimeShare.new)

    @fetch_current_shares_interactor = fetch_current_shares_interactor
    @clear_last_time_shares_interactor = clear_last_time_shares_interactor
    @add_current_time_share_interactor = add_current_time_share_interactor
    @add_current_date_share_interactor = add_current_date_share_interactor
    @add_share_interactor = add_share_interactor
  end

  def call
    fetched_shares = @fetch_current_shares_interactor.call.shares

    unless fetched_shares.empty?
      @clear_last_time_shares_interactor.call
      fetched_shares.each do |share|
        @add_current_time_share_interactor.call(share)
        @add_current_date_share_interactor.call(share)
        @add_share_interactor.call(share)
      end
    end
  end

end