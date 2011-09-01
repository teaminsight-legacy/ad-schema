require 'ad-schema/attribute_types/array'

module AD
  module Schema
    module AttributeTypes

      class HasMany < AD::Schema::AttributeTypes::Array
        key "has_many"


      end

    end
  end
end

AD::Framework.register_attribute_type(AD::Schema::AttributeTypes::HasMany)
