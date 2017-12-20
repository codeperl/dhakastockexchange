require 'features_helper'

describe 'List shares' do
  let(:repository) { ShareRepository.new }

  before do
    repository.clear

    repository.create(trading_code: '1JANATAMF',
                      last_traded_price_for_today: 6.4,
                      highest_price_for_today: 6.5,
                      lowest_price_for_today: 6.4,
                      closing_price_for_today: 6.4,
                      yesterdays_closing_price: 6.4,
                      change_for_today: 0,
                      trade_for_today: 37,
                      value_million_for_today: 0.296,
                      volume_for_today: '45,885')

    repository.create(trading_code: '1STPRIMFMF',
                      last_traded_price_for_today: 15.4,
                      highest_price_for_today: 15.7	,
                      lowest_price_for_today: 15.3,
                      closing_price_for_today: 15.4,
                      yesterdays_closing_price: 15.6,
                      change_for_today: -0.2,
                      trade_for_today: 120,
                      value_million_for_today: 3.682,
                      volume_for_today: '238,956')
  end

  it 'displays each share on the page' do
    visit '/shares'

    within '#shares' do
      assert page.has_css?('.share', count: 2), 'Expected to find 2 shares'
    end
  end
end