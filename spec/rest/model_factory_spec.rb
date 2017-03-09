# frozen_string_literal: true

RSpec.describe FreshdeskApiclient::REST::ModelFactory do
  describe '#instantiate' do
    it 'returns an instance of the class' do
      expect(subject.instantiate(:Array)).to be_a(Array)
    end
    it 'passes the arguments to the class constructor' do
      expect(subject.instantiate(:Array, 1, true).size).to eq(1)
      expect(subject.instantiate(:Array, 1, true).first).to eq(true)
    end
  end

  describe '#klass' do
    it 'returns a class' do
      expect(subject.klass(:Array)).to be_a(Class)
    end
  end

  describe '#ancestor' do
    it 'returns the parent module (namespace)' do
      expect(subject.ancestor).to eq(FreshdeskApiclient::REST)
    end
  end
end
