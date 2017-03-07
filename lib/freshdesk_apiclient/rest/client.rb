# frozen_string_literal: true
module FreshdeskApiclient
  module REST
    class Client
      include FreshdeskApiclient::Utils::Loggeable
      include FreshdeskApiclient::Utils::Camelizable

      RESOURCES = %i(tickets).freeze

      # @param [String] domain
      # @param [String] username_or_api_key
      # @param [String] password
      # @param [Logger] logger
      def initialize(domain: FreshdeskApiclient.domain,
                     username_or_api_key: FreshdeskApiclient.username_or_api_key,
                     password: FreshdeskApiclient.password,
                     logger: nil)
        @base_url = "https://#{domain}.freshdesk.com/api/v2/"
        @credentials = {username: username_or_api_key, password: password}
        @logger = logger
      end

      # obj.method_missing(symbol [, *args] )   -> result
      def method_missing(symbol, *arguments, &block)
        RESOURCES.include?(symbol) ? instance_variable(symbol) : super
      end

      def respond_to_missing?(method_sym, include_private=false)
        RESOURCES.include?(method_sym) ? true : super
      end

      private

      def instance_variable(symbol)
        class_name = camelize symbol
        variable_name = "@#{class_name.downcase}"
        if instance_variable_defined? variable_name
          instance_variable_get(variable_name)
        else
          instance_variable_set(variable_name, init_class(class_name))
        end
      end

      def init_class(class_name)
        constant(class_name).new(@base_url, credentials: @credentials, logger: logger)
      end

      def constant(class_name)
        Object.const_get('FreshdeskApiclient').const_get('REST').const_get class_name
      end
    end
  end
end
