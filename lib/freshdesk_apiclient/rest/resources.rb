# frozen_string_literal: true
require 'rest-client'
require 'forwardable'

module FreshdeskApiclient
  module REST
    class Resources
      def initialize(base_url, options={})
        @args = default_arguments options[:credentials], base_url, options[:path]
        RestClient.log = options[:logger]
      end

      def list
        execute(method: :get, headers: headers)
      end

      def create(json_payload)
        execute(method: :post, headers: content_headers, payload: json_payload)
      end

      private

      def resource
        class_name.downcase
      end

      def class_name
        full_class_name_as_array.last
      end

      def full_class_name_as_array
        full_class_name.split('::')
      end

      def full_class_name
        self.class.name
      end

      def execute(args)
        RestClient::Request.execute @args.merge(args)
      end

      def default_arguments(credentials, base_url, path=nil)
        {
          user: credentials[:username],
          password: credentials[:password],
          url: "#{base_url}/#{path || resource}"
        }
      end

      def content_headers
        headers.merge('Content-Type': 'application/json')
      end

      def headers
        {Accept: 'application/json'}
      end
    end
  end
end
