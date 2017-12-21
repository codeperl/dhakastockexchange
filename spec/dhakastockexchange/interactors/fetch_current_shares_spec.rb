require 'spec_helper'

describe FetchCurrentShares do
  let(:interactor) { FetchCurrentShares.new }

  it "succeeds" do
    expect(interactor.call).to be_a_success
  end
end
