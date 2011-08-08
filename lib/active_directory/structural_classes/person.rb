require 'active_directory/structural_classes/top'

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

ActiveDirectory.config.register_object_class(ActiveDirectory::Person)
