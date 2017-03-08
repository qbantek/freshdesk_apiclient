# frozen_string_literal: true
module FreshdeskApiclient
  module Utils
    module Camelizable
      def camelize(term)
        string = term.to_s
        format string
      end

      def format(string)
        string = string.sub(/^[a-z\d]*/) { $&.capitalize }
        string.gsub!(%r{(?:_|(/))([a-z\d]*)}) { $2.capitalize }
        string
      end
    end
  end
end
