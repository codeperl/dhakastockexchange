require 'hanami/interactor'
require_relative './helpers'

class OfficeHour
  include Hanami::Interactor
  include Helpers

  expose :office_hour

  def call
    @office_hour = parse_url('http://www.dsebd.org').css('body div.containbox div.row div header.Header div.HeaderTop span[4] span').text.strip.downcase
  end
end