class DseService
  def parse_url(url)
    Nokogiri::HTML(HTTParty.get(url))
  end

  def valid_company(company)
    company != 'Additional' && (company.length > 1) && (company.count(')') <= 1)
  end

  def find_companies
    companies = []

    parse_url('http://www.dsebd.org/company%20listing.php')
        .css('body > html table[1] tbody tr td table td table tr') # Strange but true. They have html inside body!
        .children.each do |child|

      company = child.text.strip
      companies << company if valid_company(company)

    end

    companies
  end

  def find_company_names
    companies = find_companies

    companies.map do |company|

    end
  end

  def find_company_trading_codes
    companies = find_companies

    companies.map do |company|

    end
  end

  def fetch_current_information
    company_information = parse_url('http://www.dsebd.org/latest_share_price_all.php')
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

    company_information.shift # Removing first element as it contains the column names and not the company info.

    company_information
  end

end