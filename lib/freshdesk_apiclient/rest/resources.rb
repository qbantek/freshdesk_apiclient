# frozen_string_literal: true
require 'rest-client'
require 'forwardable'
require 'base64'

module FreshdeskApiclient
  module REST
    class Resources
      def initialize(base_url, options={})
        @url = "#{base_url}/#{options[:path] || end_point}"
        @headers = headers options[:credentials]
        RestClient.log = options[:logger]
      end

      def list
        RestClient::Request.execute(method: :get,
                                    url: @url,
                                    headers: @headers.dup.reject! {|key| [:'Content-Type'].include?(key) })
      end

      def create(json_payload)
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

      def headers(credentials)
        {
          Authorization: "Basic #{Base64.encode64("#{credentials[:username]}:#{credentials[:password]}")}",
          'Content-Type': 'application/json',
          Accept: 'application/json'
        }
      end
    end
  end
end
