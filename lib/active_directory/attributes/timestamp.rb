require 'active_directory/attributes/base'

module ActiveDirectory
  module Attributes

    class Timestamp < ActiveDirectory::Attributes::Base
      key "timestamp"

      attr_accessor :value

      def initialize(value, key)
        self.value = convert(value.to_i)
      end

      def ldap_value
        # Nanosecond remainder is lost in conversion.
        (self.value.to_i * 10000000) + unix_time
      end

      protected

      def convert(val)
        Time.at((val - unix_time) / 10000000).utc
      end

      def unix_time
        (369 * 365 + 89) * 24 * 3600 * 10000000
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::Timestamp)
