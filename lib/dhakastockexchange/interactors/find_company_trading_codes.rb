require 'hanami/interactor'

class FindCompanyTradingCodes
  include Hanami::Interactor

  expose :companies
  def initialize(companies_interactor: FetchCompanies.new)
    @companies_interactor = companies_interactor
  end

  def call
    @companies = @companies_interactor.call

    @companies.map do |company|

    end
  end
end