require 'features_helper'

describe 'Last price of all shares' do
  it 'display each share, share price and other important information on the page' do
    visit '/shares'

    within '#shares' do
      assert page.has_css?('.shares', count: 2), 'Expected to find 2 shares'
    end
  end
end