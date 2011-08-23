require 'log4r'
require 'mocha'

# add the current gem root path to the LOAD_PATH
root_path = File.expand_path("../..", __FILE__)
if !$LOAD_PATH.include?(root_path)
  $LOAD_PATH.unshift(root_path)
end

require 'ad-schema'

class Assert::Context
  include Mocha::API
end

module Factory
  extend Mocha::API

  class << self

    def mock_object(methods = {})
      methods[:dn] ||= 'CN=something, DC=example, DC=com'
      methods[:fields] ||= {}
      object = mock()
      methods.each do |name, value|
        object.stubs(name).returns(value)
      end
      object
    end

  end
end
