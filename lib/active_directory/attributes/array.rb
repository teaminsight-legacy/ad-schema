require 'ad-framework/attribute_type'
require 'active_directory/attributes/string'

module ActiveDirectory
  module Attributes

    class Array < AD::Framework::AttributeType
      key "array"

      attr_accessor :item_class

      def initialize(object, attr_ldap_name, values)
        self.item_class = case attr_ldap_name.to_sym
        when :proxyaddresses
          ActiveDirectory::Attributes::String
        else
          ActiveDirectory::Attributes::String
        end
        super
      end
      
      def value_from_field
        (self.object.fields[self.attr_ldap_name] || [])
      end

      def value
        self.get_items_values(@value)
      end

      def value=(new_value)
        values = [*new_value].collect do |value|
          self.item_class.new(object, attr_ldap_name)
        end
        super(values.compact)
      end

      def ldap_value=(new_value)
        super(self.get_items_values(new_value))
      end

      protected

      def get_items_values(items)
        [*items].compact.collect(&:value)
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::Array)
