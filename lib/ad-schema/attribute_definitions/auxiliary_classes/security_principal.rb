AD::Framework.register_attributes([
  { :name => "object_sid",          :ldap_name => "objectsid",      :type => "string" },
  { :name => "object_rid",          :ldap_name => "rid",            :type => "integer" },
  { :name => "sam_account_name",    :ldap_name => "samaccountname", :type => "string" },
  { :name => "sam_account_type",    :ldap_name => "samaccounttype", :type => "flags" },
  { :name => "object_sid_history",  :ldap_name => "sidhistory",     :type => "array" }
])
