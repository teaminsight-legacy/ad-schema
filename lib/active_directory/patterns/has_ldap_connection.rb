# This pattern is intended to commonize the methods needed to communicate to the Active Directory
# backend. We do this through the LDAP protocol.
module ActiveDirectory
  module Patterns

    module HasLDAPConnection
      class << self

        def included(klass)
          klass.class_eval do
            extend ActiveDirectory::Patterns::HasLDAPConnection::ClassMethods
            include ActiveDirectory::Patterns::HasLDAPConnection::InstanceMethods
          end
        end

      end

      module InstanceMethods

        def connection
          self.class.connection
        end

      end

      module ClassMethods

        def connection
          @connection ||= ActiveDirectory.connection
        end

      end

    end

  end
end
