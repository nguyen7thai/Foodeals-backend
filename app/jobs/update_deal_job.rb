class UpdateDealJob
  include SuckerPunch::Job

  def perform
    DealCache.create(data: FetchDealService.exec.to_json)
  end
end
