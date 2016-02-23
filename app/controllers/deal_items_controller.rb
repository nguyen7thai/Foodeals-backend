require 'open-uri'

class DealItemsController < ApplicationController
  def index
    render json: DealCache.last.data
  end
end
