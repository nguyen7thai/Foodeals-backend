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
      abs_link = "#{root_url}#{link}"
      deal_page = Nokogiri::HTML(open(abs_link, "Cookie" => cookie_location))
      locations = deal_page.css('.link_map')
      evoucher = deal_page.xpath('//span[contains(text(), "(Email/SMS)")]')
      coordinate = nil
      if locations.empty?
        p "No coordinate: #{title}"
      elsif evoucher.empty?
        p "No evoucher: #{title}"
      else
        p "items: #{deal_items.count}"
        coordinate = locations.first.attribute('data-map-location').value
        coordinate = coordinate.split(',')
        deal_items << DealItem.new(title, abs_link, nil, coordinate)
      end
    end
    { deal_items: deal_items }
  end
end
