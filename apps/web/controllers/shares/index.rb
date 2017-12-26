module Web::Controllers::Shares
  class Index
    include Web::Action

    expose :shares

    def call(params)
      @shares = CurrentTimeShareRepository.new.all
    end
  end
end
