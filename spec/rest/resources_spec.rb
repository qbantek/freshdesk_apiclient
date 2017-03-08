# frozen_string_literal: true
require_relative '../../lib/freshdesk_apiclient/rest/resources' unless defined?(FreshdeskApiclient::REST::Resources)

RSpec.describe FreshdeskApiclient::REST::Resources do
  subject { FreshdeskApiclient::REST::Resources.new(:url, credentials: {username: :u, password: :p}) }

  RSpec.shared_examples 'a resource' do
    let(:get_headers) { {Accept: 'application/json'} }
    let(:post_headers) { get_headers.merge('Content-Type': 'application/json') }
    let(:resource) { subject.class.name.split('::').last.downcase }

    describe '#new' do
      it 'sets the user using given credentials' do
        expect(subject.instance_variable_get(:@args)[:user]).to eql(:u)
      end

      it 'sets the password using given credentials' do
        expect(subject.instance_variable_get(:@args)[:password]).to eql(:p)
      end

      context 'when path option is provided' do
        subject { FreshdeskApiclient::REST::Resources.new(:url, credentials: {username: :u, password: :p}, path: :foo) }
        it 'sets the url using given path' do
          expect(subject.instance_variable_get(:@args)[:url]).to eql("#{:url}/#{:foo}")
        end
      end

      context 'when path option is not provided' do
        it 'sets the url for the given resource' do
          expect(subject.instance_variable_get(:@args)[:url]).to eql("#{:url}/#{resource}")
        end
      end

      it('sets the logger on RestClient') do
        rest_client = object_double('RestClient', :log= => nil).as_stubbed_const
        logger = Logger.new(STDOUT)
        FreshdeskApiclient::REST::Resources.new(:url, credentials: {username: :u, password: :p}, logger: logger)
        expect(rest_client).to have_received(:log=).with(logger)
      end
    end

    describe '#list' do
      it('executes the request as a GET') do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.list
        expect(request).to have_received(:execute).with(hash_including(method: :get))
      end

      it 'sets the Accept header to accept JSON' do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.list
        expect(get_headers[:Accept]).to eq('application/json')
        expect(request).to have_received(:execute).with(hash_including(headers: get_headers))
      end
    end

    describe '#create' do
      it('executes the request as a POST') do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.create :payload
        expect(request).to have_received(:execute).with(hash_including(method: :post))
      end

      it 'sets the Accept header to accept JSON' do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.create :payload
        expect(request).to have_received(:execute).with(hash_including(headers: post_headers))
      end

      it 'sets the Content-Type header to indicate JSON content' do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.create :payload
        expect(post_headers[:'Content-Type']).to eq('application/json')
        expect(request).to have_received(:execute).with(hash_including(headers: post_headers))
      end

      it 'submits the payload' do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.create :payload
        expect(request).to have_received(:execute).with(hash_including(payload: :payload))
      end
    end
  end

  it_behaves_like 'a resource'
end
