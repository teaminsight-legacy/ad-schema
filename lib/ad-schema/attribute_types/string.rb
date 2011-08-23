require 'ad-framework/attribute_type'

module AD
  module Schema
    module AttributeTypes

      class String < AD::Framework::AttributeType
        key "string"

        def value=(new_value)
          super(new_value ? new_value.to_s : new_value)
        end

      end

    end
  end
end

AD::Framework.register_attribute_type(AD::Schema::AttributeTypes::String)
