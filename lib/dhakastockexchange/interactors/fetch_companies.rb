require 'hanami/interactor'
require_relative './helpers'

class FetchCompanies
  include Hanami::Interactor
  include Helpers

  expose :companies

  def initialize;end

  def valid_company(company)
    company != 'Additional' && (company.length > 1) && (company.count(')') <= 1)
  end

  def call
    @companies = []

    parse_url('http://www.dsebd.org/company%20listing.php')
        .css('body > html table[1] tbody tr td table td table tr') # Strange but true. They have html inside body!
        .children.each do |child|

      company = child.text.strip
      @companies << company if valid_company(company)

    end

    @companies
  end
end