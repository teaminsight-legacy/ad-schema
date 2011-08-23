require 'ad-schema/top'

require 'ad-schema/attribute_definitions/person'

module AD
  module Schema

    # http://msdn.microsoft.com/en-us/library/ms683895(v=vs.85).aspx
    class Person < AD::Schema::Top

      ldap_name "person"

      rdn :name

      attributes :last_name, :phone_number

      write_attributes :password

      #requires :name

    end

  end
end

AD::Framework.register_structural_class(AD::Schema::Person)
