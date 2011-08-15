module ActiveDirectory
  module Entry

    class Schema
      attr_accessor :ldap_name, :rdn
      attr_accessor :attributes, :attribute_needs

      attr_accessor :klass, :entry

      def initialize(klass)
        self.klass = klass

        self.attribute_needs = {
          :read => Set.new, :write => Set.new
        }
        self.attributes = Set.new

        if self.klass.superclass.ancestors.include?(ActiveDirectory::Classes::Base)
          parent_schema = self.klass.superclass.schema
          self.add_r_attribute_needs(parent_schema.attribute_needs[:read])
          self.add_w_attribute_needs(parent_schema.attribute_needs[:write])
        end
      end

      def add_rw_attribute_needs(attribute_names)
        self.add_r_attribute_needs(attribute_names)
        self.add_w_attribute_needs(attribute_names)
      end

      def add_r_attribute_needs(attribute_names)
        attribute_names.collect(&:to_sym).each do |name|
          self.attribute_needs[:read].add(name)
        end
      end

      def add_w_attribute_needs(attribute_names)
        attribute_names.collect(&:to_sym).each do |name|
          self.attribute_needs[:write].add(name)
        end
      end

      def build_for(entry)
        self.entry = entry
        keys = [ self.attribute_needs[:read].to_a, self.attribute_needs[:write].to_a ].flatten.uniq
        self.attributes = (keys.collect do |name|
          if !(attribute = ActiveDirectory.config.attributes[name])
            # raise(ActiveDirectory::NoAttributeError, "An attribute with the name #{name} is not defined")
          end
          attribute
        end).compact
      end

      def apply
        if self.entry
          self.attributes.each do |attribute|
            if self.attribute_needs[:read].include?(attribute.name.to_sym)
              attribute.apply_read(self.entry)
            end
            if self.attribute_needs[:write].include?(attribute.name.to_sym)
              attribute.apply_write(self.entry)
            end
          end
        end
      end

      def inspect
        attrs_display = [*(if self.entry
          "entry: #<#{self.entry.class} dn: #{self.entry.dn.inspect}>"
        else
          "klass: #{self.klass.inspect}"
        end)]
        attrs_display.push("ldap_name: #{ldap_name.inspect}")
        [ "#<#{self.class} ", attrs_display.join(", "), ">" ].join
      end

    end

  end
end
