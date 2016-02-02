class ShortUrl < ActiveRecord::Base
  require 'net/http'
  require 'socket'
  has_many :short_visits

  def make_short
    short = SecureRandom.urlsafe_base64(6, true)
    if ShortUrl.all.select { |short_url| short_url.shorty == short }.any?
      self.make_short
    else
      self.shorty = short
    end
  end

  def calculate_visits_count
    self[:visits_count] = ShortVisit.where(short_url_id: self.id).count
    self.save
  end

  def create_short_visit
    remote_ip = JSON.parse((Net::HTTP.get_response(URI('http://api.ipify.org/?format=json'))).body)
    visitor_info = JSON.parse(location_information(remote_ip["ip"]))
    ShortVisit.create!(short_url_id: self.id,
                       visitor_ip: visitor_info['ip'],
                       visitor_city: visitor_info['city'],
                       visitor_state: visitor_info['region_name'],
                       visitor_country: visitor_info['country_name'],
                       visitor_country_iso2: visitor_info['country_code'])
  end

  def location_information(ip)
    uri = URI('http://freegeoip.net/json/' + ip)
    response = Net::HTTP.get_response(uri)
    response.body
  end
end
