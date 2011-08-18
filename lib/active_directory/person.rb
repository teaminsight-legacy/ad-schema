require 'active_directory/top'

module ActiveDirectory

  # http://msdn.microsoft.com/en-us/library/ms683895(v=vs.85).aspx
  class Person < ActiveDirectory::Top

    ldap_name "person"

    rdn :name

    attributes :last_name, :phone_number

    write_attributes :password

    #requires :name

  end

end

AD::Framework.register_structural_class(ActiveDirectory::Person)
