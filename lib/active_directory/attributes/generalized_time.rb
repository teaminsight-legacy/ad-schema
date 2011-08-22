require 'time'
require 'ad-framework/attribute_type'

module ActiveDirectory
  module Attributes

    class GeneralizedTime < AD::Framework::AttributeType
      key "generalized_time"

      def value=(new_value)
        parsed_value = case new_value
        when Time
          new_value.utc
        else
          Time.parse(new_value.to_s).utc if new_value
        end
        super(parsed_value)
      end

      def ldap_value=(new_value)
        super(self.windows_time_string(new_value))
      end

      protected

      # TODO: explain what's being done here, removing punctuation and adding the .0Z
      def windows_time_string(time)
        time.utc.iso8601.gsub(/[-|:|T]/, '').gsub(/Z$/, '.0Z') if time
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::GeneralizedTime)
