require 'ad-schema/attribute_types/integer'

module AD
  module Schema
    module AttributeTypes
      class Flags < AD::Schema::AttributeTypes::Integer

        module UserAccountControl

          def user_account_control_values
            { :useraccountcontrol => {
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
end
