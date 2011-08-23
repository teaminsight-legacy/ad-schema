require 'ad-framework/attribute_type'

module AD
  module Schema
    module AttributeTypes

      class Boolean < AD::Framework::AttributeType
        key 'boolean'

        def value=(new_value)
          value = if ["false", "0"].include?(new_value.to_s.downcase)
            false
          elsif !new_value.nil?
            true
          else
            nil
          end
          super(value)
        end

      end

    end
  end
end

AD::Framework.register_attribute_type(AD::Schema::AttributeTypes::Boolean)
