# frozen_string_literal: true
require_relative '../../lib/freshdesk_apiclient/rest/resources' unless defined?(FreshdeskApiclient::REST::Resources)

RSpec.describe FreshdeskApiclient::REST::Resources do
  subject { FreshdeskApiclient::REST::Resources.new(:url, credentials: {username: :u, password: :p}) }

  RSpec.shared_examples 'a resource' do
    let(:get_headers) { {Authorization: "Basic dTpw\n", Accept: 'application/json'} }
    let(:post_headers) { get_headers.merge('Content-Type': 'application/json') }
    let(:path) { subject.class.name.split('::').last.downcase }

    describe '#new' do
      context 'when path option is provided' do
        subject { FreshdeskApiclient::REST::Resources.new(:url, credentials: {username: :u, password: :p}, path: :foo) }
        it 'sets the url using given path' do
          expect(subject.instance_variable_get(:@url)).to eql("#{:url}/#{:foo}")
        end
      end

      context 'when path option is not provided' do
        it 'sets the url for the given resource' do
          expect(subject.instance_variable_get(:@url)).to eql("#{:url}/#{path}")
        end
      end

      it 'sets the Authorization header for the given credentials' do
        expect(subject.instance_variable_get(:@headers)[:Authorization]).to eql(get_headers[:Authorization])
      end

      it 'sets the Accept header to accept JSON' do
        expect(subject.instance_variable_get(:@headers)[:Accept]).to eql(get_headers[:Accept])
      end

      it 'sets the Content-Type header to indicate JSON content' do
        expect(subject.instance_variable_get(:@headers)[:'Content-Type']).to eql(post_headers[:'Content-Type'])
      end

      it('sets the logger on RestClient') do
        rest_client = object_double('RestClient', :log= => nil).as_stubbed_const
        logger = Logger.new(STDOUT)
        FreshdeskApiclient::REST::Resources.new(:url,
                                                credentials: {
                                                  username: :u,
                                                  password: :p
                                                },
                                                logger: logger)
        expect(rest_client).to have_received(:log=).with(logger)
      end
    end

    describe '#list' do
      it('executes the request as a GET') do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.list
        expect(request).to have_received(:execute).with(method: :get, url: "#{:url}/#{path}", headers: get_headers)
      end
    end

    describe '#create' do
      it('executes the request as a POST') do
        request = object_double('RestClient::Request', execute: nil).as_stubbed_const
        subject.create :payload
        expect(request).to have_received(:execute).with(method: :post,
                                                        url: "#{:url}/#{path}",
                                                        headers: post_headers,
                                                        payload: :payload)
      end
    end
  end

  it_behaves_like 'a resource'
end
