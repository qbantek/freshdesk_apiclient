# frozen_string_literal: true
require 'logger' unless defined?(Logger)
unless defined?(FreshdeskApiclient::Utils::Camelizable)
  require_relative '../../lib/freshdesk_apiclient/utils/camelizable'
end
require_relative '../../lib/freshdesk_apiclient/utils/loggeable' unless defined?(FreshdeskApiclient::Utils::Loggeable)
require_relative '../../lib/freshdesk_apiclient/rest/client' unless defined?(FreshdeskApiclient::REST::Client)
require_relative '../../lib/freshdesk_apiclient/rest/tickets' unless defined?(FreshdeskApiclient::REST::Tickets)
require_relative '../../lib/freshdesk_apiclient/rest/resources' unless defined?(FreshdeskApiclient::REST::Resources)

describe FreshdeskApiclient::REST::Client do
  before do
    FreshdeskApiclient.domain = :domain
    FreshdeskApiclient.username_or_api_key = :api_key
  end
  subject { FreshdeskApiclient::REST::Client.new }
  describe '#new' do
    it 'sets the base_url for the given domain' do
      expect(subject.instance_variable_get(:@base_url)).to eql("https://#{:domain}.freshdesk.com/api/v2/")
    end

    context 'when password is provided' do
      before { FreshdeskApiclient.password = :password }
      subject { FreshdeskApiclient::REST::Client.new }
      it 'sets the credentials for the given parameters' do
        expect(subject.instance_variable_get(:@credentials)[:user]).to eq(:api_key)
        expect(subject.instance_variable_get(:@credentials)[:password]).to eq(:password)
      end
    end

    context 'when password is not provided' do
      before { FreshdeskApiclient.password = nil }
      it 'sets the credentials for the given api_key and default password' do
        expect(subject.instance_variable_get(:@credentials)[:user]).to eq(:api_key)
        expect(subject.instance_variable_get(:@credentials)[:password]).to eq('X')
      end
    end

    context 'when a logger option is not provided' do
      before { FreshdeskApiclient.logger = nil }
      it('does not sets the logger') { expect(subject.instance_variable_get(:@logger)).to be_nil }
    end

    context 'when a logger option is provided' do
      subject { FreshdeskApiclient::REST::Client.new(logger: Logger.new(STDOUT)) }
      it('sets the logger') { expect(subject.instance_variable_get(:@logger)).to be_a(Logger) }
    end
  end

  FreshdeskApiclient::REST::Client::RESOURCES.each do |method|
    it("responds to ##{method}") { expect(subject).to respond_to(method) }

    describe "##{method}" do
      it do
        class_name = FreshdeskApiclient::Utils::Camelizable.camelize method.to_s
        klass = Object.const_get('FreshdeskApiclient').const_get('REST').const_get class_name
        expect(subject.send(method)).to be_an_instance_of(klass)
      end
    end

    it "memoizes the result of ##{method}" do
      first = subject.send(method)
      second = subject.send(method)
      expect(first.object_id).to eq(second.object_id)
    end
  end
end
