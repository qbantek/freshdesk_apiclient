# frozen_string_literal: true
require 'logger'
require_relative '../../lib/freshdesk_apiclient/utils/camelizable'

RSpec.describe FreshdeskApiclient::REST::Client do
  subject { FreshdeskApiclient::REST::Client.new(:domain, :api_key) }
  describe '#new' do
    it 'sets the base_url for the given domain' do
      expect(subject.instance_variable_get(:@base_url)).to eql("https://#{:domain}.freshdesk.com/api/v2/")
    end

    it 'sets the credentials for the given parameters' do
      expect(subject.instance_variable_get(:@credentials)).to be_a(Hash)
    end

    context 'when a logger option is not provided' do
      it('does not sets the logger') { expect(subject.instance_variable_get(:@logger)).to be_nil }
    end

    context 'when a logger option is provided' do
      subject { FreshdeskApiclient::REST::Client.new(:domain, :api_key, nil, logger: Logger.new(STDOUT)) }
      it('sets the logger') { expect(subject.instance_variable_get(:@logger)).to be_a(Logger) }
    end
  end

  FreshdeskApiclient::REST::Client::RESOURCES.each do |method|
    it("responds to ##{method}") { expect(subject).to respond_to(method) }

    describe "##{method}" do
      it do
        klass = Object.const_get('FreshdeskApiclient').const_get('REST').const_get subject.camelize(method.to_s)
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
