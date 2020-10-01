require 'logger'

module BuiltinRuby
  module Mixins
    module Loggable
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def logger
          @logger ||= Logger.new(STDOUT)
        end
      end
    end
  end
end
