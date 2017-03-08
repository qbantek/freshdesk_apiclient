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

      def respond_to_missing?(method, *)
        RESOURCES.include?(method) ? true : super
      end

      private

      def instance_variable(symbol)
        class_name = camelize symbol
        ivar = as_ivar class_name

        instance_variable_defined?(ivar) ? instance_variable_get(ivar) : set(ivar, class_name)
      end

      def set(ivar, class_name)
        obj = instantiate class_name
        instance_variable_set ivar, obj
      end

      def as_ivar(name)
        "@#{name.downcase}"
      end

      def instantiate(class_name)
        klass(class_name, 'FreshdeskApiclient', 'REST').new(@base_url, credentials: @credentials, logger: logger)
      end

      def klass(class_name, *module_names)
        c = Object
        module_names.each {|m| c = c.const_get m }
        c.const_get class_name
      end
    end
  end
end
