require 'open-uri'

class HotdealService
  CITY_CODE = [
    HO_CHI_MINH = "ho-chi-minh",
    HA_NOI = "ha-noi"
  ]

  def self.fetch_for_city(city_code)
    page_url = "http://www.hotdeal.vn/#{city_code}/an-uong"
    root_url = "http://www.hotdeal.vn"
    page = Nokogiri::HTML(open(page_url))
    deal_items = []
    page.css('#block-main .product').each do |deal|
      title = deal.css('[itemprop=name]').text
      link = deal.css('[itemprop=name]').attribute('href').value
      abs_link = "#{root_url}#{link}"
      price = deal.css('.price__value').text

      if deal.css('.hd-evoucher').count > 0
        deal_page = Nokogiri::HTML(open(abs_link))
        locations = deal_page.css('.image_map')
        coordinate = nil
        if locations.empty? || locations.first.attribute('src').value.blank?
          p "No coordinate: #{title}"
        else
          p "items: #{deal_items.count}"
          string = locations.first.attribute('src').value
          regex = /\d{2,3}\.\d+,\d{2,3}\.\d+/
          coordinate = string.match(regex).to_s
          coordinate = coordinate.split(',')
          deal_items << DealItem.new(title, abs_link, nil, coordinate, price, 'hotdeal')
        end
      end
    end
    deal_items
  end

  def self.exec
    deal_items = CITY_CODE.inject([]) do |result, code|
      result += self.fetch_for_city(code)
    end
  end
end

#http://maps.googleapis.com/maps/api/staticmap?&zoom=13&size=600x350&maptype=roadmap&markers=color:red|label:H|16.0737929,108.21261800000002&sensor=false
