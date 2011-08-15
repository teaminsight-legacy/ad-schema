require 'time'
require 'active_directory/attributes/base'

module ActiveDirectory
  module Attributes

    class GeneralizedTime < ActiveDirectory::Attributes::Base
      key "generalized_time"

      attr_accessor :value

      def initialize(value, key)
        self.value = case value.class
        when Time
          value.utc
        else
          if value
            Time.parse(value.to_s).utc
          end
        end
      end

      def ldap_value
        if self.value
          self.value.utc.iso8601.gsub(/[-|:|T]/, '').gsub(/Z$/, '.0Z')
        end
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::Attributes::GeneralizedTime)
