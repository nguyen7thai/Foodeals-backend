require 'open-uri'

class FetchDealService
  def self.exec
    page_url = "http://www.nhommua.com/ho-chi-minh/an-uong"
    root_url = "http://www.nhommua.com"
    cookie_location = "NewCityId=1"
    page = Nokogiri::HTML(open(page_url, "Cookie" => cookie_location))
    deal_items = []
    page.css('#cate_list > li').each do |deal|
      title = deal.css('.list_name').text
      link = deal.css('.img > a').attribute('href').value
      deal_page = Nokogiri::HTML(open("#{root_url}#{link}", "Cookie" => cookie_location))
      locations = deal_page.css('.link_map')
      coordinate = nil
      if locations.present?
        p "items: #{deal_items.count}"
        coordinate = locations.first.attribute('data-map-location').value
        coordinate = coordinate.split(',')
        deal_items << DealItem.new(title, link, nil, coordinate)

      else
        p "No coordinate: #{title}"
      end
    end
    { deal_items: deal_items }
  end
end
