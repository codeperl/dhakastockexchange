module Helpers

  def parse_url(url)
    Nokogiri::HTML(HTTParty.get(url))
  end
end