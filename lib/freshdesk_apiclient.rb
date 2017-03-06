# frozen_string_literal: true
require 'freshdesk_apiclient/version'

require 'freshdesk_apiclient/utils/loggeable'
require 'freshdesk_apiclient/utils/camelizable'

require 'freshdesk_apiclient/rest/resources'
require 'freshdesk_apiclient/rest/tickets'
require 'freshdesk_apiclient/rest/client'

module FreshdeskApiclient
  def self.domain
    @domain
  end

  def self.domain=(domain)
    @domain = domain
  end

  def self.username_or_api_key
    @username_or_api_key
  end

  def self.username_or_api_key=(username_or_api_key)
    @username_or_api_key = username_or_api_key
  end

  def self.password
    @password ||= 'X'
  end

  def self.password=(password)
    @password = password
  end
end
