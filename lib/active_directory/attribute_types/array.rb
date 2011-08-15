require 'active_directory/attribute_types/base'

# TODO use array class
module ActiveDirectory
  module AttributeTypes

    class Array < ActiveDirectory::AttributeTypes::Base

      key "array"

      def items_class
        @items_class ||= case(self.attribute.name.to_sym)
          when :proxy_addresses
            String
          else
            String
        end
      end

      def apply_read(entry)
        entry.meta_class.class_eval <<-APPLY_READ

          def #{self.attribute.name}
            unless @#{self.attribute.name}
              values = (self.fields["#{self.attribute.ldap_name}"] || []).first
              @#{self.attribute.name} = values.collect do |value|
                #{self.attribute.attribute_type.items_class}.new(value)
              end
            end
            @#{self.attribute.name}
          end

        APPLY_READ
      end

      def apply_write(entry)
        entry.meta_class.class_eval <<-APPLY_WRITE

          def #{self.attribute.name}=(new_value)
            @#{self.attribute.name} = nil
            self.fields["#{self.attribute.ldap_name}"] = [*new_value].collect(&:to_s)
            self.#{self.attribute.name}
          end

        APPLY_WRITE
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::AttributeTypes::Array)