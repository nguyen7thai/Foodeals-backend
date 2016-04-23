require 'open-uri'

class FetchDealService
  CITY_CODE = [
    HO_CHI_MINH = "ho-chi-minh",
    HA_NOI = "ha-noi"
  ]

  def self.fetch_for_city(city_code)
    page_url = "http://www.nhommua.com/#{city_code}/an-uong"
    root_url = "http://www.nhommua.com"
    page = Nokogiri::HTML(open(page_url))
    deal_items = []
    page.css('#cate_list > li').each do |deal|
      title = deal.css('.list_name').text
      link = deal.css('.img > a').attribute('href').value
      abs_link = "#{root_url}#{link}"
      price = deal.css('.price').text
      deal_page = Nokogiri::HTML(open(abs_link))
      locations = deal_page.css('.link_map')
      evoucher = deal_page.xpath('//span[contains(text(), "(Email/SMS)")]')
      coordinate = nil
      if locations.empty? || locations.first.attribute('data-map-location').value.blank?
        p "No coordinate: #{title}"
      elsif evoucher.empty?
        p "No evoucher: #{title}"
      else
        p "items: #{deal_items.count}"
        coordinate = locations.first.attribute('data-map-location').value
        coordinate = coordinate.split(',')
        deal_items << DealItem.new(title, abs_link, nil, coordinate, price)
      end
    end
    deal_items
  end

  def self.exec
    deal_items = CITY_CODE.inject([]) do |result, code|
      result += self.fetch_for_city(code)
    end
    { deal_items: deal_items }
  end
end
