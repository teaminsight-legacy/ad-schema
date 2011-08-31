AD::Framework.register_attributes([
  { :name => "name",                :ldap_name => "cn",                   :type => "string" },
  { :name => "system_flags",        :ldap_name => "systemflags",          :type => "flags" },
  { :name => "display_name",        :ldap_name => "displayname",          :type => "string" },
  { :name => "description",         :ldap_name => "description",          :type => "string" },
  { :name => "proxy_addresses",     :ldap_name => "proxyaddresses",       :type => "array" },
  { :name => "when_created",        :ldap_name => "whencreated",          :type => "generalized_time" },
  { :name => "when_changed",        :ldap_name => "whenchanged",          :type => "generalized_time" },
  { :name => "admin_display_name",  :ldap_name => "admindisplayname",     :type => "string" },
  { :name => "admin_description",   :ldap_name => "admindescription",     :type => "string" },
  { :name => "unix_member_of",      :ldap_name => "mssfu30posixmemberof", :type => "has_many" },
  { :name => "member_of",           :ldap_name => "memberof",             :type => "has_many" }
])
