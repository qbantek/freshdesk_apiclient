# frozen_string_literal: true

unless defined?(FreshdeskApiclient::Utils::Loggeable)
  require_relative '../../lib/freshdesk_apiclient/utils/loggeable'
end


describe FreshdeskApiclient::Utils::Loggeable do
  class DummyClass
  end

  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(FreshdeskApiclient::Utils::Loggeable)
  end

  describe '.standard_out_logger' do
    it {expect(@dummy_class.standard_out_logger).to be_a(Logger)}
    it 'defaults to Logger::INFO level' do
      expect(@dummy_class.standard_out_logger.level).to eq(Logger::INFO)
    end
  end
  
  describe '.logger' do
    it 'memoizes the result of .logger' do
      first = @dummy_class.logger
      second = @dummy_class.logger
      expect(first.object_id).to eq(second.object_id)
    end
  end
end
