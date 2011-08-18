require 'ad-framework'

require 'active_directory/attributes'

Dir[File.expand_path("../active_directory/attributes/*.rb", __FILE__)].each do |filename|
  require "active_directory/attributes/#{File.basename(filename)}"
end

require 'active_directory/user'

module ActiveDirectory
end
