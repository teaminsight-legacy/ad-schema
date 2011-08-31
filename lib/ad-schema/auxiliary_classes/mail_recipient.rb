require 'ad-framework/auxiliary_class'
require 'ad-schema/attribute_definitions/auxiliary_classes/mail_recipient'

module AD
  module Schema
    module AuxiliaryClasses

      module MailRecipient
        include AD::Framework::AuxiliaryClass

        ldap_name "mailRecipient"
        attributes :directory_comments, :legacy_exchange_dn, :secretary_dn, :address_books,
          :phone_number

      end

    end
  end
end
