require 'ad-framework/structural_class'

module ActiveDirectory

  # http://msdn.microsoft.com/en-us/library/ms683975(v=vs.85).aspx
  class Top < AD::Framework::StructuralClass

    ldap_name "top"

    rdn :name

    attributes :name, :system_flags, :display_name, :description, :proxy_addresses,
      :when_created, :when_changed, :admin_display_name, :admin_description, :unix_member_of

  end

end

AD::Framework.register_structural_class(ActiveDirectory::Top)
