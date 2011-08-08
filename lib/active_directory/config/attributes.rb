module ActiveDirectory
  class Config

    class Attributes < Hash
      
      def [](name)
        super(name.to_sym)
      end
      
      def []=(name, attribute)
        super(name.to_sym, attribute)
      end

      def add(definition)
        attribute = definition if definition.kind_of?(ActiveDirectory::Attribute)
        attribute ||= ActiveDirectory::Attribute.new(definition)
        self[attribute.name] = attribute
      end

    end

  end
end
