require 'active_directory/attributes/base'
require 'active_directory/attributes/string'

module ActiveDirectory
  module Attributes

    class Array < ActiveDirectory::Attributes::Base
      key "array"

      attr_accessor :values

      def initialize(values, key)
        value_type = case key.to_sym
        when :proxy_address
          ActiveDirectory::Attributes::String
        else
          ActiveDirectory::Attributes::String
        end
        self.values = [*values].collect do |value|
          value_type.new(value)
        end
      end

      def value
        [*self.values].collect(&:value)
      end

      def ldap_value
        [*self.values].collect(&:ldap_value)
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::Array)
