require 'active_directory/attribute_types/base'

require 'active_directory/attributes/system_flags'

module ActiveDirectory
  module AttributeTypes

    class Flags < ActiveDirectory::AttributeTypes::Base

      key "flags"

      def flags_class
        @flags_class ||= case(self.attribute.name.to_sym)
          when :system_flags
            ActiveDirectory::Attributes::SystemFlags
        end
      end

      def apply_read(entry)
        entry.meta_class.class_eval <<-APPLY_READ

          def #{self.attribute.name}
            unless @#{self.attribute.name}
              value = (self.fields["#{self.attribute.ldap_name}"] || []).first
              flags = #{self.attribute.attribute_type.flags_class}.new(value)
              @#{self.attribute.name} = flags
            end
            @#{self.attribute.name}
          end

        APPLY_READ
      end

      def apply_write(entry)
        entry.meta_class.class_eval <<-APPLY_WRITE

          def #{self.attribute.name}=(new_value)
            @#{self.attribute.name} = #{self.attribute.attribute_type.flags_class}.new(new_value)
            self.fields["#{self.attribute.ldap_name}"] = [ new_value.to_s ]
            self.#{self.attribute.name}
          end

        APPLY_WRITE
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::AttributeTypes::Flags)