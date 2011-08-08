# ActiveDirectory.configure(config)
#
# ActiveDirectory.configure do
#   server = 1.1.1.1:2222
#   # OR #
#   host = 1.1.1.1
#   port = 2222
#   base = "DC=something, DC=com"
#   encryption = :simple_tls
#   authentication = {               # or auth
#      :username => "something/someone",
#      :password => "1234"
#    }
#   logger = Rails.logger            # be nice and do this for them?
#   mode = :test                     # or live
#   config.ldap = {
#     :search_size_supported => false
#   }
# end
require 'ostruct'

require 'active_directory/config/mapping'
require 'active_directory/config/attributes'

module ActiveDirectory

  class Config
    attr_accessor :host, :port, :base, :encryption, :authentication, :logger, :mode, :ldap
    attr_accessor :attribute_types, :object_classes, :attributes
    alias :auth   :authentication

    def initialize(config = nil)
      @object_classes = ActiveDirectory::Config::Mapping.new
      @attribute_types = ActiveDirectory::Config::Mapping.new
      @attributes = ActiveDirectory::Config::Attributes.new
    end

    def server=(server_string)
      self.host, self.port = server_string.split(":")
    end

    def authentication=(new_hash)
      @authentication = OpenStruct.new(new_hash)
    end
    alias :auth=  :authentication=

    def ldap
      @ldap ||= OpenStruct.new
    end
    def ldap=(new_hash)
      @ldap = OpenStruct.new(new_hash)
    end

    def attributes=(definitions)
      definitions.each do |definition|
        @attributes.add(definition)
      end
    end
    
    def register_attribute_type(attribute_type)
      self.attribute_types.add(attribute_type.key, attribute_type)
    end
    def register_object_class(object_class)
      self.object_classes.add(object_class.schema.ldap_name, object_class)
    end

  end

end
