# frozen_string_literal: true
require_relative '../../../lib/core_extensions/string/camelize'
RSpec.describe StringExtensions do
  using StringExtensions

  describe '#camelize' do
    context 'given Foo_bar' do
      it { expect('Foo_bar'.camelize).to eq('FooBar') }
    end

    context 'given Foo::Bar' do
      it { expect('Foo::Bar'.camelize).to eq('FooBar') }
    end

    context 'given fooBar' do
      it { expect('fooBar'.camelize).to eq('Foobar') }
    end
  end
end
