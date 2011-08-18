require 'ostruct'
require 'ad-ldap'

require 'ad-framework/config/mapping'

module AD
  module Framework

    class Config
      attr_accessor :attributes, :object_classes

      def initialize
        self.mappings = AD::Framework::Config::Mapping.new

        #self.object_classes = AD::Framework::Config::Mapping.new
        #self.attributes = AD::Framework::Config::Mapping.new
      end

      def ldap(&block)
        if block
          AD::LDAP.configure(&block)
        end
        AD::LDAP
      end
      alias :adapter :ldap

      def logger
        self.adapter.logger
      end
      def logger=(new_logger)
        self.adapter.config.logger = new_logger
      end

      [ :search_size_supported, :mappings, :run_commands ].each do |method|

        define_method(method) do
          self.adapter.config.send(method)
        end

        writer = "#{method}="
        define_method(writer) do |new_value|
          self.adapter.config.send(writer, new_value)
        end

      end

    end

  end
end
