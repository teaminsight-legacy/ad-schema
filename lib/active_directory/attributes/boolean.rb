module ActiveDirectory
  module Attributes

    class Boolean
      attr_accessor :value

      def initialize(value)
        self.value = if ["false", "0"].include?(value.to_s.downcase)
          false
        elsif !value.nil?
          true
        else
          nil
        end
      end

    end

  end
end
