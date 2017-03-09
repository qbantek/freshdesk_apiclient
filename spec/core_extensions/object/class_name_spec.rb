# frozen_string_literal: true
require_relative '../../../lib/core_extensions/object/class_name'
RSpec.describe ObjectExtensions do
  module Foo
    class Bar
    end
  end

  context 'when refining Object' do
    using ObjectExtensions

    context 'for any Foo:Bar instance' do
      subject { Foo::Bar.new }
      describe '#full_class_name' do
        it { expect(subject.full_class_name).to eq('Foo::Bar') }
      end

      describe '#full_class_name_as_array' do
        it('should return an Array of 2 items') do
          expect(subject.full_class_name_as_array).to be_a(Array)
          expect(subject.full_class_name_as_array.size).to eq(2)
        end
        it('first array item should eq Foo') { expect(subject.full_class_name_as_array[0]).to eq('Foo') }
        it('second array item should eq Bar') { expect(subject.full_class_name_as_array[0]).to eq('Foo') }
      end

      describe '#class_name' do
        it { expect(subject.class_name).to eq('Bar') }
      end

      describe '#namespace_as_array' do
        it('should return an Array of 1 item') do
          expect(subject.namespace_as_array).to be_a(Array)
          expect(subject.namespace_as_array.size).to eq(1)
        end
        it('first array item should eq Foo') { expect(subject.namespace_as_array[0]).to eq('Foo') }
      end
    end
  end
end
