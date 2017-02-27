# frozen_string_literal: true
require 'freshdesk_apiclient/version'

require 'freshdesk_apiclient/utils/loggeable'
require 'freshdesk_apiclient/utils/camelizable'

require 'freshdesk_apiclient/rest/resource'
require 'freshdesk_apiclient/rest/tickets'
require 'freshdesk_apiclient/rest/client'

module FreshdeskApiclient
  # require 'rest_client'
  # require 'json'
  #
  # freshdesk_domain = 'YOUR_DOMAIN'
  # user_name_or_api_key = 'YOUR_API_KEY'
  # password_or_x = 'X'
  #
  # json_payload = {status: 2,
  #                 priority: 1,
  #                 description: 'test ticket creation',
  #                 subject: 'new ticket sample',
  #                 email: 'test@test.com'}.to_json
  #
  # freshdesk_api_path = 'api/v2/tickets'
  #
  # freshdesk_api_url  = "https://#{freshdesk_domain}.freshdesk.com/#{freshdesk_api_path}"
  #
  # site = RestClient::Resource.new(freshdesk_api_url, user_name_or_api_key, password_or_x)
  #
  # begin
  #   response = site.post(json_payload, content_type: 'application/json')
  #   puts "response_code: #{response.code}"
  #   puts "Location Header: #{response.headers[:location]}"
  #   puts "response_body: #{response.body}"
  # rescue RestClient::Exception => exception
  #   puts 'API Error: Your request is not successful. Email us at support@freshdesk.com with the following X-Request-Id'
  #   puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
  #   puts "Response Code: #{exception.response.code} Response Body: #{exception.response.body} "
  # end
end
