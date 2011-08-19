require 'ad-framework/attribute_type'

module ActiveDirectory
  module Attributes

    class Integer < AD::Framework::AttributeType
      key "integer"

      def value=(new_value)
        super(new_value ? new_value.to_i : new_value)
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::Integer)
