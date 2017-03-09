# frozen_string_literal: true
require_relative '../../../lib/freshdesk_apiclient'
require_relative '../../../lib/freshdesk_apiclient/rest/model_factory'
require_relative '../../../lib/freshdesk_apiclient/utils/camelizable'

module FreshdeskApiclient
  module REST
    class Client
      include FreshdeskApiclient::Utils::Loggeable

      RESOURCES = %i(tickets).freeze

      # @param [String] domain
      # @param [String] username_or_api_key
      # @param [String] password
      # @param [Logger] logger
      def initialize(domain: FreshdeskApiclient.domain,
                     username_or_api_key: FreshdeskApiclient.username_or_api_key,
                     password: FreshdeskApiclient.password, logger: FreshdeskApiclient.logger)
        @base_url = "https://#{domain}.freshdesk.com/api/v2/"
        @credentials = {user: username_or_api_key, password: password}
        @logger = logger
      end

      # obj.method_missing(symbol [, *args] )   -> result
      def method_missing(symbol, *arguments, &block)
        RESOURCES.include?(symbol) ? instance_variable(symbol) : super
      end

      def respond_to_missing?(method, *)
        RESOURCES.include?(method) ? true : super
      end

      private

      def instance_variable(symbol)
        get_set_ivar FreshdeskApiclient::Utils::Camelizable.camelize(symbol)
      end

      def get_set_ivar(class_name)
        ivar = "@#{class_name.downcase}"
        instance_variable_defined?(ivar) ? instance_variable_get(ivar) : set_ivar(ivar, class_name)
      end

      def set_ivar(ivar, class_name)
        obj = ModelFactory.new.instantiate class_name, @base_url, credentials: @credentials, logger: logger
        instance_variable_set ivar, obj
      end
    end
  end
end
