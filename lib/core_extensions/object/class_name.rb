# frozen_string_literal: true
module ObjectExtensions
  refine Object do
    def class_name
      full_class_name_as_array.last
    end

    def full_class_name_as_array
      full_class_name.split('::')
    end

    def full_class_name
      self.class.name
    end
  end
end
