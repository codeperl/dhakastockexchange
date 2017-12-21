require 'hanami/interactor'

class FindCompanyNames
  include Hanami::Interactor

  expose :companies
  def initialize(companiesInteractor: FetchCompanies.new)
    @companiesInteractor = companiesInteractor
  end

  def call
    @companies = @companiesInteractor.call

    @companies.map do |company|

    end
  end
end