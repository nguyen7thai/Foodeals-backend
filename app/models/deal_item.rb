class DealItem
  extend ActiveSupport
  attr_accessor :title, :address, :lat, :long, :url

  def initialize(title, url, address, coordinate)
    self.title = title
    self.url = url
    self.address = address || ""
    self.lat = coordinate.try(:first)
    self.long = coordinate.try(:last)
  end
end
