require 'active_directory/patterns/has_ldap_connection'
require 'active_directory/patterns/has_schema'
require 'active_directory/patterns/searchable'

module ActiveDirectory
  module Classes

    class Base
      include ActiveDirectory::Patterns::HasLDAPConnection
      include ActiveDirectory::Patterns::HasSchema
      include ActiveDirectory::Patterns::Searchable

      attr_accessor :meta_class, :errors, :fields

      def initialize(attributes = {})
        self.meta_class = class << self; self; end

        self.fields = (attributes.delete(:fields) || ActiveDirectory::Entry::Fields.new)

        self.attributes = attributes
        self.errors = {}

        self.schema.apply
      end

      def inspect
        attr_display = self.schema.attribute_needs[:read].collect do |name|
          "#{name}: #{self.send(name).inspect}"
        end
        [ "#<#{self.class} ", attr_display.join(", "), ">" ].join
      end

    end

  end
end
