class ShareRepository < Hanami::Repository
  def find_one_by(trading_code, version)
    shares.where(trading_code: trading_code).where(version: version).last
  end
end
