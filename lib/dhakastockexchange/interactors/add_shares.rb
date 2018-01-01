require 'time'
require 'hanami/interactor'
require_relative './../constants/office'

class AddShares
  include Hanami::Interactor
  include Office

  expose :shares

  def initialize(office_hour_interactor: OfficeHour.new,
                 fetch_current_shares_interactor: FetchCurrentShares.new,
                 clear_last_time_shares_interactor: ClearLastTimeShares.new,
                 add_current_date_share_interactor: AddCurrentDateShare.new,
                 add_current_time_share_interactor: AddCurrentTimeShare.new,
                 add_share_interactor: AddShare.new,
                 share_repository: ShareRepository.new,
                 current_time_share_repository: CurrentTimeShareRepository.new,
                 share_update_version_repository: ShareUpdateVersionRepository.new)

    @office_hour_interactor = office_hour_interactor
    @fetch_current_shares_interactor = fetch_current_shares_interactor
    @clear_last_time_shares_interactor = clear_last_time_shares_interactor
    @add_current_time_share_interactor = add_current_time_share_interactor
    @add_current_date_share_interactor = add_current_date_share_interactor
    @add_share_interactor = add_share_interactor
    @current_time_share_repository = current_time_share_repository
    @share_update_version_repository = share_update_version_repository
    @share_repository = share_repository
  end

  def call
    if Office::OPEN == @office_hour_interactor.call.office_hour
      generate_shares_information
    else
      generate_day_closing_share_information
    end

    @shares = @current_time_share_repository.all
  end

  def generate_day_closing_share_information
    closing_start_time = Time.parse "2:31 pm"
    closing_end_time = Time.parse "2:35 pm"
    current_time = Time.now

    if current_time >= closing_start_time && current_time <=closing_end_time
      generate_shares_information
    end
  end

  def generate_shares_information
    fetched_shares = @fetch_current_shares_interactor.call.shares

    unless fetched_shares.empty?
      share_update_version = Hash.new
      share_update_version[:fake_data] = nil
      last_share_update_version = @share_update_version_repository.create(share_update_version)

      @clear_last_time_shares_interactor.call
      fetched_shares.each do |share|
        share[:version] = last_share_update_version.version

        searched_share = @share_repository.find_one_by(
            share[:trading_code], previous_version(last_share_update_version.version)
        )

        share[:last_traded_price_change_than_last_update] = calculate_last_traded_price_change_than_last_update(
            searched_share, share[:last_traded_price_for_today]
        )

        share[:value_in_million_change_than_last_update] = calculate_value_in_million_change_than_last_update(
            searched_share, share[:value_million_for_today]
        )

        share[:traded_change_than_last_update] = calculate_traded_change_than_last_update(
            searched_share, share[:trade_for_today]
        )

        @add_current_time_share_interactor.call(share)
        @add_current_date_share_interactor.call(share)
        @add_share_interactor.call(share)
      end
    end
  end

  def previous_version(current_version)
    current_version - 1
  end

  def calculate_last_traded_price_change_than_last_update(share, current_upate_for_last_traded_price)
    if share && current_upate_for_last_traded_price
      last_traded_price_change_than_last_update = current_upate_for_last_traded_price - share[:last_traded_price_for_today]
    else
      last_traded_price_change_than_last_update = current_upate_for_last_traded_price
    end

    last_traded_price_change_than_last_update
  end

  def calculate_value_in_million_change_than_last_update(share, current_update_for_value_in_million)
    if share && current_update_for_value_in_million
      value_in_million_change_than_last_update = current_update_for_value_in_million - share[:value_million_for_today]
    else
      value_in_million_change_than_last_update = current_update_for_value_in_million
    end

    value_in_million_change_than_last_update
  end

  def calculate_traded_change_than_last_update(share, current_upate_for_traded)
    if share && current_upate_for_traded
      traded_change_than_last_update = current_upate_for_traded - share[:trade_for_today]
    else
      traded_change_than_last_update = current_upate_for_traded
    end

    traded_change_than_last_update
  end

end