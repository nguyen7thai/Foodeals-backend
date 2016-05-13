class DealItem
  extend ActiveSupport
  attr_accessor :title, :address, :lat, :long, :url, :price, :source

  def initialize(title, url, address, coordinate, price, source)
    self.title = title
    self.url = url
    self.address = address || ""
    self.price = price
    self.lat = coordinate.try(:first)
    self.long = coordinate.try(:last)
    self.source = source
  end
end
