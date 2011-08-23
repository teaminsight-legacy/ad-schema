require 'active_directory/attributes/integer'
require 'active_directory/attributes/boolean'

module ActiveDirectory
  module Attributes

    class Flags < ActiveDirectory::Attributes::Integer
      key "flags"

      attr_accessor :meta_class, :accepted_values

      def initialize(object, attr_ldap_name)
        self.meta_class = class << self; self; end
        self.accepted_values = self.class.defined_values[attr_ldap_name.to_sym]
        super

        self.define_value_methods!
      end

      def value
        self
      end

      protected

      def to_boolean(new_value)
        new_value = !!new_value
        @converter ||= ActiveDirectory::Attributes::Boolean.new(self.object, self.attr_ldap_name, new_value)
        @converter.value = new_value
        @converter.value
      end


      # TODO: describe what this is doing, using the meta class to define methods just for this
      # instance, blah blah blah
      def define_value_methods!
        self.accepted_values.each do |(name, bit)|
          self.meta_class.class_eval <<-FLAG_METHODS

            def #{name}
              ((@value || 0) & #{bit}) != 0
            end

            def #{name}=(new_value)
              boolean = self.to_boolean(new_value)
              current = self.#{name}
              if boolean ^ current
                self.value = ((@value || 0) ^ #{bit})
              end
              self.#{name}
            end

          FLAG_METHODS
        end
      end

      class << self
        def defined_values
          @defined_values ||= {
            :systemflags => {
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
            },
            :useraccountcontrol => {
              :execute_logon_script =>                0x00000001,
              :disabled =>                            0x00000002,
              :home_directory_required =>             0x00000008,
              :locked_out =>                          0x00000010,
              :no_password_required =>                0x00000020,
              :password_locked =>                     0x00000040,
              :can_send_encrypted_password =>         0x00000080,
              :local =>                               0x00000100,
              :normal =>                              0x00000200,
              :domain_trust =>                        0x00000800,
              :workstation_trust =>                   0x00001000,
              :server_trust =>                        0x00002000,
              :password_permanent =>                  0x00010000,
              :mns_logon =>                           0x00020000,
              :smartcard_required =>                  0x00040000,
              :delegation_trusted =>                  0x00080000,
              :not_delegated =>                       0x00100000,
              :use_des_key_only =>                    0x00200000,
              :preauth_optional =>                    0x00400000,
              :password_expired =>                    0x00800000,
              :authenticate_for_delegation_trusted => 0x01000000,
            }
          }
        end
      end

    end
  end
end

AD::Framework.register_attribute_type(ActiveDirectory::Attributes::Flags)
