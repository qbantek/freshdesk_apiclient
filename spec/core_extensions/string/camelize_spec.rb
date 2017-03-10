# frozen_string_literal: true
require_relative '../../../lib/core_extensions/string/camelize'
RSpec.describe StringExtensions do
  using StringExtensions

  describe '#camelize' do
    context 'given Foo_bar' do
      it { expect('Foo_bar'.camelize).to eq('FooBar') }
    end

    it { expect('Foo::Bar'.camelize).to eq('FooBar') }
    it { expect('fooBar'.camelize).to eq('Foobar') }
  end
end
