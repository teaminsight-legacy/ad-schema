require 'ad-framework/attribute_type'

module AD
  module Schema
    module AttributeTypes

      class Integer < AD::Framework::AttributeType
        key "integer"

        def value=(new_value)
          super(new_value ? new_value.to_i : new_value)
        end

      end

    end
  end
end

AD::Framework.register_attribute_type(AD::Schema::AttributeTypes::Integer)
