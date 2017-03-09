# frozen_string_literal: true
require 'rest-client'
require 'forwardable'
require_relative '../../../lib/core_extensions/object/class_name'

module FreshdeskApiclient
  module REST
    class Resources
      using ObjectExtensions

      ACCEPT_HEADER = {Accept: 'application/json'}.freeze
      ACCEPT_AND_CONTENT_HEADERS = ACCEPT_HEADER.merge('Content-Type': 'application/json')

      def initialize(base_url, options={})
        @base_url = base_url
        @credentials = options[:credentials]
        RestClient.log = options[:logger]
      end

      def list(path=nil)
        url = full_url path
        execute(url: url, method: :get, headers: ACCEPT_HEADER)
      end

      def create(json_payload)
        url = full_url
        execute(url: url, method: :post, headers: ACCEPT_AND_CONTENT_HEADERS, payload: json_payload)
      end

      private

      def execute(args)
        RestClient::Request.execute @credentials.merge(args)
      end

      def full_url(path=nil)
        "#{@base_url}/#{path || resource}"
      end

      def resource
        class_name.downcase
      end
    end
  end
end
