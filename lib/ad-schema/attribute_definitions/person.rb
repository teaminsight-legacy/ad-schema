AD::Framework.register_attributes([
  { :name => "last_name",     :ldap_name => "sn",               :type => "string" },
  { :name => "phone_number",  :ldap_name => "telephonenumber",  :type => "string" },
  { :name => "password",      :ldap_name => "userpassword",     :type => "string" },
])