# frozen_string_literal: true
module FreshdeskApiclient
  module Utils
    module Loggeable
      def logger
        @logger ||= standard_out_logger
      end

      def standard_out_logger
        require 'logger'
        Logger.new(STDOUT).tap {|log| log.level = Logger::INFO }
      end
    end
  end
end
