require 'active_directory/attributes/base'

module ActiveDirectory
  module Attributes

    class String < ActiveDirectory::Attributes::Base
      key "string"

      attr_accessor :value

      def initialize(value, key)
        self.value = value ? value.to_s : nil
      end

      def ldap_value
        self.value
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::String)
