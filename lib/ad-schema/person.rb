require 'ad-schema/top'

require 'ad-schema/attribute_definitions/person'

module AD
  module Schema

    # http://msdn.microsoft.com/en-us/library/ms683895(v=vs.85).aspx
    class Person < AD::Schema::Top

      ldap_name "person"
      attributes :last_name, :phone_number
      must_set :name

    end

  end
end

AD::Framework.register_structural_class(AD::Schema::Person)
