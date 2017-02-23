# frozen_string_literal: true
require 'base64'

module FreshdeskApiclient
  module REST
    class Client
      include FreshdeskApiclient::Utils::Loggeable
      include FreshdeskApiclient::Utils::Camelizable

      RESOURCES = %i(tickets).freeze

      # @param [String] domain
      # @param [String] username_or_api_key
      # @param [String] password
      # @param [Hash] options
      def initialize(domain, username_or_api_key, password='X', options={})
        @base_url = "https://#{domain}.freshdesk.com/api/v2/"
        @credentials = {username: username_or_api_key, password: password}
        @logger = options[:logger] if options.key?(:logger) && options[:logger].respond_to?(:info)
      end

      # obj.method_missing(symbol [, *args] )   -> result
      def method_missing(symbol, *arguments, &block)
        if RESOURCES.include? symbol
          class_name = camelize(symbol.to_s)
          variable = "@#{class_name.downcase}"
          unless instance_variable_defined? variable
            klass = Object.const_get('FreshdeskApiclient').const_get('REST').const_get class_name
            instance_variable_set(variable, klass.new(@base_url, credentials: @credentials, logger: logger))
          end
          instance_variable_get(variable)
        else
          super
        end
      end

      def respond_to_missing?(method_sym, include_private=false)
        RESOURCES.include?(method_sym) ? true : super
      end

      private

      def auth_header(username, password)
        "Basic #{Base64.encode64("#{username}:#{password}")}"
      end
    end
  end
end
