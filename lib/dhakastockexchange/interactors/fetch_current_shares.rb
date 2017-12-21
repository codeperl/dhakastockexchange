require 'hanami/interactor'
require_relative './helpers'

class FetchCurrentShares
  include Hanami::Interactor
  include Helpers

  expose :shares

  def initialize;end

  def call
    @shares = parse_url('http://www.dsebd.org/latest_share_price_all.php')
                              .css('body div table')
                              .children
                              .map do |child|
      {}.tap do |row|
        row[:trading_code] = child.css('td')[1].text.strip
        row[:last_traded_price_for_today] = child.css('td')[2].text.strip.to_f
        row[:highest_price_for_today] = child.css('td')[3].text.strip.to_f
        row[:lowest_price_for_today] = child.css('td')[4].text.strip.to_f
        row[:closing_price_for_today] = child.css('td')[5].text.strip.to_f
        row[:yesterdays_closing_price] = child.css('td')[6].text.strip.to_f
        row[:change_for_today] = child.css('td')[7].text.strip.to_f
        row[:trade_for_today] = child.css('td')[8].text.strip.to_f
        row[:value_million_for_today] = child.css('td')[9].text.strip.to_f
        row[:volume_for_today] = child.css('td')[10].text.strip
      end
    end

    @shares.shift

    @shares
  end
end