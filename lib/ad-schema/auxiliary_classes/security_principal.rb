require 'ad-framework/auxiliary_class'
require 'ad-schema/attribute_definitions/auxiliary_classes/security_principal'

module AD
  module Schema
    module AuxiliaryClasses

      module SecurityPrincipal
        include AD::Framework::AuxiliaryClass

        ldap_name "securityPrincipal"
        attributes :object_sid, :object_rid, :sam_account_name, :sam_account_type,
          :object_sid_history

        must_set :sam_account_name
      end

    end
  end
end
