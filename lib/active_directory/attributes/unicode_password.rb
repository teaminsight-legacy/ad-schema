require 'ad-framework/attribute_type'

module ActiveDirectory
  module Attributes

    class UnicodePassword < AD::Framework::AttributeType
      key "unicode_password"

      def value=(new_value)
        self.ldap_value = new_value
      end

      def ldap_value=(new_value)
        if new_value
          new_value = new_value.inspect.split('').collect{|c| "#{c}\000"}.join
          self.object.fields[self.attr_ldap_name] = [new_value]
        end
      end

    end

  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::UnicodePassword)
