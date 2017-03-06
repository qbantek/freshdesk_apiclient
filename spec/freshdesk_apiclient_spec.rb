# frozen_string_literal: true
require 'spec_helper'

RSpec.describe FreshdeskApiclient do
  it('has a version number') { expect(FreshdeskApiclient::VERSION).not_to be nil }

  before { FreshdeskApiclient.domain = :domain }
  it('allows to set domain') { expect(FreshdeskApiclient.domain).to eq(:domain) }

  before { FreshdeskApiclient.username_or_api_key = :u }
  it('allows to set username_or_api_key') { expect(FreshdeskApiclient.username_or_api_key).to eq(:u) }

  before { FreshdeskApiclient.password = :p }
  it('allows to set password') { expect(FreshdeskApiclient.password).to eq(:p) }

  context 'when password was not set' do
    before { FreshdeskApiclient.password = nil }
    it('has a default password') { expect(FreshdeskApiclient.password).to eq('X') }
  end
end
