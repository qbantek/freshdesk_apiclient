# frozen_string_literal: true
module StringExtensions
  refine String do
    def camelize
      split(/[^a-z0-9]/i).map { |word| word.capitalize }.join
    end
  end unless String.new.respond_to?(:camelize)
end
