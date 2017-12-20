require_relative '../../spec_helper'

describe Share do
  it 'can be initialized with attributes' do
    share = Share.new(trading_code: '1JANATAMF')
    share.trading_code.must_equal '1JANATAMF'

=begin
    trading_code: '1JANATAMF', last_traded_price_for_today: 100.0, highest_price_for_today: 122.0, lowest_price_for_today: 98.0,
        closing_price_for_today: 102.0,  yesterdays_closing_price: 105.0, change_for_today: 3.0, trade_for_today: 4297272.0, value_million_for_today: 433.48,
        volume_for_today: '2,87,560'
=end
  end
end
