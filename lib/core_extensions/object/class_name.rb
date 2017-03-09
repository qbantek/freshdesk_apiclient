# frozen_string_literal: true
module ObjectExtensions
  unless Object.new.respond_to?(:class_name)
    refine Object do
      def class_name
        full_class_name_as_array.last
      end

      def namespace_as_array
        full_class_name_as_array[0...-1]
      end

      def full_class_name_as_array
        full_class_name.split('::')
      end

      def full_class_name
        self.class.name
      end
    end
  end
end
