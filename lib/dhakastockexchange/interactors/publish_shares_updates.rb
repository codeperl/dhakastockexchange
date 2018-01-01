require 'hanami/interactor'
require_relative './../pubsub/realtime_app/broadcast'

class PublishSharesUpdates
  include Hanami::Interactor
  include RealTimeApp

  def initialize(broadcast_service: Broadcast.new,
                 share_update_version_repository: ShareUpdateVersionRepository.new,
                 current_date_share_repository: CurrentDateShareRepository.new)

    @broadcast_service = broadcast_service
    @share_update_version_repository = share_update_version_repository
    @current_date_share_repository = current_date_share_repository
  end

  def call(channel, shares)
    @broadcast_service.message(channel, prepare_content(shares))
  end

  def prepare_content(shares)
    content = ''

    if shares
      shares.each_with_index do |share, index|
        content << "<tr class='row-container #{share_update_class_by_last_traded_price_change_than_last_update(share.last_traded_price_change_than_last_update)}'>"
        content << '<td data-title="Serial">' << "#{index + 1}" << '</td>'
        content << '<th scope="row">' << "#{share.trading_code}" << '</th>'
        content << '<td data-title="Last traded price" data-type="currency">' << "#{share.last_traded_price_for_today}" << '</td>'
        content << '<td data-title="Highest price" data-type="currency">' << "#{share.highest_price_for_today}" << '</td>'
        content << '<td data-title="Lowest price" data-type="currency">' << "#{share.lowest_price_for_today}" << '</td>'
        content << '<td data-title="Closing price" data-type="currency">' << "#{share.closing_price_for_today}" << '</td>'
        content << '<td data-title="Yesterdays closing price" data-type="currency">' << "#{share.yesterdays_closing_price}" << '</td>'
        content << '<td data-title="Changes" data-type="currency">' << "#{share.change_for_today}" << '</td>'
        content << '<td data-title="Traded" data-type="currency">' << "#{share.trade_for_today}" << '</td>'
        content << '<td data-title="Value in million" data-type="currency">' << "#{share.value_million_for_today}" << '</td>'
        content << '<td data-title="Volume">' << "#{share.volume_for_today}" << '</td>'
        content << '</tr>'
      end
    end

    content
  end
end

def share_update_class_by_last_traded_price_change_than_last_update(last_traded_price_change_than_last_update)
  stylesheet_class_name = ''

  if last_traded_price_change_than_last_update > 0.0
    stylesheet_class_name = 'up'
  elsif last_traded_price_change_than_last_update < 0.0
    stylesheet_class_name = 'down'
  end

  stylesheet_class_name
end