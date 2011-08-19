require 'ad-framework/attribute_type'

module ActiveDirectory
  module Attributes

    class String < AD::Framework::AttributeType
      key "string"

      def value=(new_value)
        super(new_value ? new_value.to_s : new_value)
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::String)
