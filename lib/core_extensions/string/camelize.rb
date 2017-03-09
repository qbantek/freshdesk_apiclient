# frozen_string_literal: true
module StringExtensions
  unless String.new.respond_to?(:camelize)
    refine String do
      def camelize
        split(/[^a-z0-9]/i).map(&:capitalize).join
      end
    end
  end
end
