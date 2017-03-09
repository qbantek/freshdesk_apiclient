# frozen_string_literal: true
require_relative '../../../lib/core_extensions/object/class_name'

module FreshdeskApiclient
  module REST
    class ModelFactory
      using ObjectExtensions

      def instantiate(class_name, *args)
        klass(class_name).new(*args)
      end

      def klass(class_name)
        ancestor.const_get class_name
      end

      def ancestor
        c = Object
        namespace_as_array.each {|m| c = c.const_get m }
        c
      end
    end
  end
end
