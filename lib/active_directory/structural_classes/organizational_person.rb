require 'active_directory/structural_classes/person'

module ActiveDirectory

  class OrganizationalPerson < ActiveDirectory::Person

    ldap_name "organizationalPerson"

    rdn :name

    attributes :address, :home_address, :assistant_dn, :company_name, :country_code, :country_name,
      :department, :division, :email, :employee_id, :fax_number, :generation_qualifier, :first_name,
      :initials, :locality_name, :manager_dn, :organizational_unit, :other_mailbox, :middle_name

  end

end

ActiveDirectory.config.register_object_class(ActiveDirectory::OrganizationalPerson)
