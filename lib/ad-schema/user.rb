require 'ad-schema/organizational_person'
require 'ad-schema/auxiliary_classes/mail_recipient'
require 'ad-schema/auxiliary_classes/security_principal'

require 'ad-schema/attribute_definitions/user'

module AD
  module Schema

    class User < AD::Schema::OrganizationalPerson
      include AD::Schema::AuxiliaryClasses::MailRecipient
      include AD::Schema::AuxiliaryClasses::SecurityPrincipal

      ldap_name "user"
      attributes :account_expires, :home_drive, :locked_out_at, :profile_path,
        :script_path, :account_control, :parameters, :principal_name, :unix_user_id, :unix_group_id,
        :unix_password, :unix_home_directory, :unix_login_shell, :unix_nis_domain
      read_attributes :admin_count, :last_bad_password_at, :bad_password_count, :last_logged_in_at,
        :logged_in_count, :primary_group_id, :password_last_set_at, :service_principal_names
      write_attributes :unicode_password

    end

  end
end

AD::Framework.register_structural_class(AD::Schema::User)
