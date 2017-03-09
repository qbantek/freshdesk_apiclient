# frozen_string_literal: true
require_relative 'resources_spec' unless defined?(FreshdeskApiclient::REST::Resources)
require_relative '../../lib/freshdesk_apiclient/rest/resources' unless defined?(FreshdeskApiclient::REST::Resources)
require_relative '../../lib/freshdesk_apiclient/rest/tickets' unless defined?(FreshdeskApiclient::REST::Tickets)

describe FreshdeskApiclient::REST::Tickets do
  subject { FreshdeskApiclient::REST::Tickets.new(:url, credentials: {user: :u, password: :p}) }

  it_behaves_like 'a resource'
end
