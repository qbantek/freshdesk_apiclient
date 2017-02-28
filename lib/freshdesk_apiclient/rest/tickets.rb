# frozen_string_literal: true
require_relative '../../../lib/freshdesk_apiclient/rest/resources' unless defined?(FreshdeskApiclient::REST::Resources)

module FreshdeskApiclient
  module REST
    class Tickets < FreshdeskApiclient::REST::Resources; end
  end
end
