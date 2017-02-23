# frozen_string_literal: true
module FreshdeskApiclient
  module REST
    class Tickets < FreshdeskApiclient::REST::Resource
      def initialize(base_url, options)
        super base_url, options
      end
    end
  end
end
