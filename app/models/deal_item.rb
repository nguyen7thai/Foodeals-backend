class DealItem
  extend ActiveSupport
  attr_accessor :title, :address, :lat, :long, :url, :price

  def initialize(title, url, address, coordinate, price)
    self.title = title
    self.url = url
    self.address = address || ""
    self.price = price
    self.lat = coordinate.try(:first)
    self.long = coordinate.try(:last)
  end
end
