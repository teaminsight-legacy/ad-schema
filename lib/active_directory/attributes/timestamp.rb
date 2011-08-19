require 'ad-framework/attribute_type'

module ActiveDirectory
  module Attributes

    class Timestamp < AD::Framework::AttributeType
      key "timestamp"

      attr_accessor :value

      def value=(new_value)
        super(convert(new_value.to_i))
      end

      def ldap_value=(new_value)
        # Nanosecond remainder is lost in conversion.
        super((new_value.to_i * 10000000) + unix_time)
      end

      protected

      # TODO: explain what is being done here, how we are converting from windows ticks to
      # unix timestamp and back
      def convert(val)
        unless val.zero? || val == 0x7FFFFFFFFFFFFFFF
          Time.at((val - unix_time) / 10000000).utc
        end
      end

      def unix_time
        (369 * 365 + 89) * 24 * 3600 * 10000000
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::Timestamp)
