require 'active_directory/structural_classes/base'
require 'active_directory/entry/fields'

module ActiveDirectory

  # http://msdn.microsoft.com/en-us/library/ms683975(v=vs.85).aspx
  class Top < ActiveDirectory::Classes::Base

    ldap_name "top"

    rdn :name

    attributes :dn, :name, :system_flags, :display_name, :description, :proxy_addresses,
      :when_created, :when_changed, :admin_display_name, :admin_description, :unix_member_of

  end

end

ActiveDirectory.config.register_object_class(ActiveDirectory::Top)
