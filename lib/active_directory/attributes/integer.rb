require 'active_directory/attributes/base'

module ActiveDirectory
  module Attributes

    class Integer < ActiveDirectory::Attributes::Base
      key "integer"

      attr_accessor :value

      def initialize(value, key)
        self.value = value ? value.to_i : nil
      end

      def ldap_value
        self.value.to_s
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::Integer)
