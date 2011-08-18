require 'ad-framework'

require 'active_directory/config'
require 'active_directory/connection'
require 'active_directory/exceptions'
require 'active_directory/attributes'

module ActiveDirectory
  class << self
    attr_accessor :config, :connection

    def configure(config = nil)
      self.config = ActiveDirectory::Config.new(config)
      if block_given?
        yield self.config
      end
      self.connection = ActiveDirectory::Connection.new(self.config)

      self.define_attributes_types
      self.define_object_classes
      self.define_supported_attributes

      self
    end

    def define_attributes_types
      Dir[File.expand_path("../active_directory/attributes/*.rb", __FILE__)].each do |filename|
        require "active_directory/attributes/#{File.basename(filename)}"
      end
    end

    def define_object_classes
      Dir[File.expand_path("../active_directory/structural_classes/*.rb", __FILE__)].each do |filename|
        require "active_directory/structural_classes/#{File.basename(filename)}"
      end
    end

    def define_supported_attributes
      require "active_directory/attribute"
      self.config.attributes = ATTRIBUTE_DEFINITIONS
    end

  end
end
