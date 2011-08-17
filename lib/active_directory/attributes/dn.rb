require 'active_directory/attributes/base'

module ActiveDirectory
  module Attributes

    class Dn < ActiveDirectory::Attributes::Base
      key "dn"

      attr_accessor :value, :ldap_value

      def initialize(value, key)
        self.value = self.ldap_value = value
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::Dn)
