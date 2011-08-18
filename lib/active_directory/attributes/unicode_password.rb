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
        if self.value
          self.value.inspect.split('').collect{|c| "#{c}\000"}.join
        end
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::UnicodePassword)
