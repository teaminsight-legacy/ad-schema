AD::Framework.register_attributes([
  { :name => "directory_comments",  :ldap_name => "info",               :type => "string" },
  { :name => "legacy_exchange_dn",  :ldap_name => "legacyexchangedn",   :type => "string" },
  { :name => "secretary_dn",        :ldap_name => "secretary",          :type => "has_one" },
  { :name => "address_books",       :ldap_name => "showinaddressbook",  :type => "has_many" }
])
