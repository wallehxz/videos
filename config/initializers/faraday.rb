require 'faraday'

$youku_conn = Faraday.new(:url => Settings.youku_api_url) do |faraday|
  faraday.request  :url_encoded
  faraday.response :logger
  faraday.adapter  Faraday.default_adapter
end

$baidu_api = Faraday.new(:url => Settings.baidu_ip_api_url) do |faraday|
  faraday.request  :url_encoded
  faraday.response :logger
  faraday.adapter  Faraday.default_adapter
end
