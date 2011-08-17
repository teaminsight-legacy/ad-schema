require 'active_directory/attributes/base'

module ActiveDirectory
  module Attributes

    class UnicodePassword < ActiveDirectory::Attributes::Base
      key "unicode_password"

      attr_accessor :value

      def initialize(value, key)
        self.value = value
      end

      def ldap_value
        self.value.to_s
      end

    end

  end
end

# ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::UnicodePassword)
