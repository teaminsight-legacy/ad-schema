require 'active_directory/attribute_types/base'

module ActiveDirectory
  module AttributeTypes

    class String < ActiveDirectory::AttributeTypes::Base

      key "string"

      def apply_read(entry)
        entry.meta_class.class_eval <<-APPLY_READ

          def #{self.attribute.name}
            @#{self.attribute.name} ||= (self.fields["#{self.attribute.ldap_name}"] || []).first
          end

        APPLY_READ
      end

      def apply_write(entry)
        entry.meta_class.class_eval <<-APPLY_WRITE

          def #{self.attribute.name}=(new_value)
            @#{self.attribute.name} = nil
            self.fields["#{self.attribute.ldap_name}"] = [ new_value.to_s ]
            self.#{self.attribute.name}
          end

        APPLY_WRITE
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::AttributeTypes::String)