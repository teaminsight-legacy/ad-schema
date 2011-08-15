module ActiveDirectory
  module Attributes

    class Base

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
