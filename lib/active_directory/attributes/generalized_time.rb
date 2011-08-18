require 'time'
require 'ad-framework/attribute_type'

module ActiveDirectory
  module Attributes

    class GeneralizedTime < AD::Framework::AttributeType
      key "generalized_time"

      def value=(new_value)
        value = case new_value.class
        when Time
          new_value.utc
        else
          if new_value
            Time.parse(new_value.to_s).utc
          end
        end
        super(value)
      end

      def ldap_value=(new_value)
        super(new_value.utc.iso8601.gsub(/[-|:|T]/, '').gsub(/Z$/, '.0Z'))
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::GeneralizedTime)
