require 'ad-schema/organizational_person'
#require 'active_directory/auxillary_classes/posix_account'
#require 'active_directory/auxillary_classes/shadow_account'
#require 'active_directory/auxillary_classes/mail_recipient'
#require 'active_directory/auxillary_classes/security_principal'

require 'ad-schema/attribute_definitions/user'

module AD
  module Schema

    class User < AD::Schema::OrganizationalPerson
      #include ActiveDirectory::AuxillaryClasses::PosixAccount
      #include ActiveDirectory::AuxillaryClasses::ShadowAccount
      #include ActiveDirectory::AuxillaryClasses::MailRecipient
      #include ActiveDirectory::AuxillaryClasses::SecurityPrincipal

      ldap_name "user"

      rdn :name

      attributes :account_expires, :home_directory, :home_drive, :locked_out_at, :profile_path,
        :script_path, :account_control, :parameters, :principal_name, :uid

      read_attributes :admin_count, :last_bad_password_at, :bad_password_count, :last_logged_in_at,
        :logged_in_count, :primary_group_id, :password_last_set_at, :service_principal_names

      write_attributes :unicode_password

    end

  end
end

AD::Framework.register_structural_class(AD::Schema::User)
