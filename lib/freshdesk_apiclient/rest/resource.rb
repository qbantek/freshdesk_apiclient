# frozen_string_literal: true
require 'rest-client'

module FreshdeskApiclient
  module REST
    class Resource
      def initialize(base_url, options)
        @url = "#{base_url}/#{options[:path] || end_point}"
        @headers = headers options[:credentials][:user], options[:credentials][:password]
        @logger = options[:logger]
      end

      def list
        RestClient::Request.execute(method: :get,
                                    url: @url,
                                    headers: @headers)
      end

      def create(json_payload)
        @logger.info json_payload

        RestClient::Request.execute(method: :post,
                                    url: @url,
                                    headers: @headers,
                                    payload: json_payload)
      end

      protected

      def end_point
        self.class.name.split('::').last.downcase
      end

      private

      def headers(username, password)
        {
          Authorization: "Basic #{Base64.encode64("#{username}:#{password}")}",
          'Content-Type': 'application/json',
          Accept: 'application/json'
        }
      end
    end
  end
end
