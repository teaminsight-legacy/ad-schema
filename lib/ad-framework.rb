require 'ad-framework/config'
require 'ad-framework/structural_class'

module AD
  module Framework
    class << self

      def configure
        if block_given?
          yield self.config
        end
        self.config
      end

      def config
        @config ||= AD::Framework::Config.new
      end

      def connection
        self.config.adapter
      end

    end
  end
end
