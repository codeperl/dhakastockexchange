class ShareService

  def store_current_information
    dse_service = DseService.new
    share_repository = ShareRepository.new
    dse_service.fetch_current_information.each do |row|
      share_repository.create(row)
    end
  end
end