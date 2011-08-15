require 'time'

module ActiveDirectory
  module Attributes

    class GeneralizedTime
      attr_accessor :value

      def initialize(value)
        self.value = case value.class
        when Time
          value.utc
        else
          Time.parse(value.to_s).utc
        end
      end

      def to_time
        self.value
      end

      def to_ldap_value
        self.value.utc.iso8601.gsub(/[-|:|T]/, '').gsub(/Z$/, '.0Z')
      end

    end

  end
end
