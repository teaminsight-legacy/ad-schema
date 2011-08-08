module ActiveDirectory
  module AttributeTypes
  
    class Base
      attr_accessor :attribute
      
      def initialize(attribute)
        self.attribute = attribute
      end
      
      class << self
        
        def key(new_value = nil)
          if new_value
            @key = new_value
          end
          @key
        end
        
      end
      
    end
  
  end
end