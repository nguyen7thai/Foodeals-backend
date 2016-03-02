require 'open-uri'

class DealItemsController < ApplicationController
  def index
    last_cache = DealCache.last
    if last_cache.created_at < 12.hour.ago
      UpdateDealJob.perform_async
    end
    render json: DealCache.last.data
  end
end
