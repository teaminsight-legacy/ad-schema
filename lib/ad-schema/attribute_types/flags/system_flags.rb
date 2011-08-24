require 'ad-schema/attribute_types/integer'

module AD
  module Schema
    module AttributeTypes
      class Flags < AD::Schema::AttributeTypes::Integer

        module SystemFlags

          def system_flags_values
            { :systemflags => {
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
            }
          end

        end

      end
    end
  end
end


