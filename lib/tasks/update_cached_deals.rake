namespace :deals do
  desc "Add missing county to cities"
  task :update_cached => :environment do |t|
    DealCache.create(data: FetchDealService.exec.to_json)
  end
end
