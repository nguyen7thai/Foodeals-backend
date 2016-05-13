require 'open-uri'

class FetchDealService
  REGISTERED_SERVICE = [NhommuaService, HotdealService]

  def self.exec
    deal_items = REGISTERED_SERVICE.inject([]) do |result, service|
      result += service.exec
    end
    { deal_items: deal_items }
  end
end
