require 'ad-framework/attribute_type'

module ActiveDirectory
  module Attributes

    class Dn < AD::Framework::AttributeType
      key "dn"
    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::Dn)
