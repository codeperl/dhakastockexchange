class CurrentDateShareRepository < Hanami::Repository

  def find_one_by(trading_code, version)
    current_date_shares.where(trading_code: trading_code).where(version: version).last
  end
end
