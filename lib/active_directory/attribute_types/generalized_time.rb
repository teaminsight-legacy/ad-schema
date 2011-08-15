require 'active_directory/attribute_types/base'

require 'active_directory/attributes/generalized_time'

module ActiveDirectory
  module AttributeTypes

    class GeneralizedTime < ActiveDirectory::AttributeTypes::Base

      key "generalized_time"

      def apply_read(entry)
        entry.meta_class.class_eval <<-APPLY_READ

          def #{self.attribute.name}
            unless @#{self.attribute.name}
              value = (self.fields["#{self.attribute.ldap_name}"] || []).first
              generalized_time = ActiveDirectory::Attributes::GeneralizedTime.new(value)
              @#{self.attribute.name} = generalized_time.to_time
            end
            @#{self.attribute.name}
          end

        APPLY_READ
      end

      def apply_write(entry)
        entry.meta_class.class_eval <<-APPLY_WRITE

          def #{self.attribute.name}=(new_value)
            generalized_time = ActiveDirectory::Attributes::GeneralizedTime.new(new_value)
            @#{self.attribute.name} = generalized_time.to_time
            self.fields["#{self.attribute.ldap_name}"] = [ generalized_time.to_ldap_value ]
            self.#{self.attribute.name}
          end

        APPLY_WRITE
      end

    end

  end
end

ActiveDirectory.config.register_attribute_type(ActiveDirectory::AttributeTypes::GeneralizedTime)
