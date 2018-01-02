require 'hanami/interactor'
require_relative './../pubsub/realtime_app/broadcast'

class PublishSharesUpdates
  include Hanami::Interactor
  include Hanami::Helpers # FIXME! ROMAN! HANAMI HELPER IS HERE TO MANAGE VIEW!
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

    if ! shares.empty?
      shares.each_with_index do |share, index|
        content << "<tr class='row-container #{row_color_by_value(share.last_traded_price_change_than_last_update)}'>"
        content << '<td data-title="Serial">' << "#{index + 1}" << '</td>'
        content << '<th scope="row">' << "#{share.trading_code}" << '</th>'
        content << '<td data-title="Last traded price" data-type="currency">' << "#{share.last_traded_price_for_today}" << '</td>'
        content << '<td data-title="Highest price" data-type="currency">' << "#{share.highest_price_for_today}" << '</td>'
        content << '<td data-title="Lowest price" data-type="currency">' << "#{share.lowest_price_for_today}" << '</td>'
        content << '<td data-title="Closing price" data-type="currency">' << "#{share.closing_price_for_today}" << '</td>'
        content << '<td data-title="Yesterdays closing price" data-type="currency">' << "#{share.yesterdays_closing_price}" << '</td>'
        content << '<td data-title="Changes" data-type="currency">' << "#{share.change_for_today}" << '</td>'
        content << '<td data-title="Traded" data-type="currency">' << "#{format_number(share.trade_for_today)}" << '</td>'
        content << '<td data-title="Value in million" data-type="currency">' << "#{share.value_million_for_today}" << '</td>'
        content << '<td data-title="Volume">' << "#{format_number(share.volume_for_today)}" << '</td>'
        content << '</tr>'
      end
    else
      content << '<tr class="row-container"><td colspan="11">There is no update yet.</td></tr>'
    end

    content
  end

  def row_color_by_value(value) # FIXME! ROMAN! THE SAME CODE HAS BEEN WRITTEN FOR HANAMI VIEW HELPER!
    stylesheet_class_name = ''

    if value > 0.0
      stylesheet_class_name = 'up'
    elsif value < 0.0
      stylesheet_class_name = 'down'
    end

    stylesheet_class_name
  end
end