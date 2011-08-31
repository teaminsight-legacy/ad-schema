require 'ad-schema/attribute_types/integer'

module AD
  module Schema
    module AttributeTypes
      class Flags < AD::Schema::AttributeTypes::Integer

        module SAMAccountType

          def sam_account_type_values
            { :samaccounttype => {
                # Object flags
                :domain =>              0x00000000,
                :group =>               0x10000000,
                :non_security_group =>  0x10000001,
                :alias =>               0x20000000,
                :non_security_alias =>  0x20000001,

                # Account flags
                :user =>                0x30000000,
                :machine =>             0x30000001,
                :trust =>               0x30000002,

                # Group flags
                :app_basic =>           0x40000000,
                :app_query =>           0x40000001,

                :account_type_max =>    0x7FFFFFFF
              }
            }
          end

        end

      end
    end
  end
end


