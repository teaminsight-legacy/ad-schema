require 'active_directory/attributes/boolean'

module ActiveDirectory
  module Attributes

    class SystemFlags
      attr_accessor :ldap_value

      VALUES = {
        # Attribute flags
        :not_replicated =>                  0x00000001,
        :replicated_to_global_catalog =>    0x00000002,
        :constructed =>                     0x00000004,
        
        # Cross-Ref Object flags
        :naming_context_ntds =>             0x00000001,
        :naming_context_domain =>           0x00000002,

        # Object flags
        :category_one_object =>             0x00000010,
        :deleted_immediately =>             0x02000000,
        :cannot_be_moved =>                 0x04000000,
        :cannot_be_renamed =>               0x08000000,
        :cannot_be_deleted =>               0x80000000,

        # Object Configuration Partition flags
        :can_be_moved_with_restrictions =>  0x10000000,
        :can_be_moved =>                    0x20000000,
        :can_be_renamed =>                  0x40000000,
      }

      def initialize(ldap_value = nil)
        self.ldap_value = ldap_value.to_i
      end
      
      def to_ldap_value
        self.ldap_value.to_s
      end

      VALUES.each do |(name, bit)|
        
        self.class_eval <<-FLAG_METHODS
        
          def #{name}
            (self.ldap_value & #{bit}) == 0
          end
          
          def #{name}=(new_value)
            boolean = ActiveDirectory::Attributes::Boolean.new(new_value).value
            current = self.#{name}
            if boolean ^ current
              self.ldap_value = (self.ldap_value ^ #{bit})
            end
            self.#{name}
          end
        
        FLAG_METHODS
        
      end

    end

  end
end
