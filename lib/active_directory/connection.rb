require 'benchmark'

require 'active_directory/ldap/adapter'
require 'active_directory/ldap/logger'
require 'active_directory/ldap/search_args'

module ActiveDirectory

  class Connection
    attr_accessor :adapter, :run_commands, :logger, :settings

    def initialize(config)
      self.adapter = ActiveDirectory::LDAP::Adapter.new(config)
      self.logger = ActiveDirectory::LDAP::Logger.new(config.logger)

      self.settings = config.ldap
      self.settings.search_size_supported = true if self.settings.search_size_supported.nil?

      self.run_commands = (config.mode != :test)
    end

    def add(args = {})
      self.run(:add, args)
    end

    def delete(dn)
      self.run(:delete, { :dn => dn })
    end

    def replace_attribute(dn, field, value)
      self.run(:replace_attribute, dn, field, value)
    end

    def delete_attribute(dn, field)
      self.run(:delete_attribute, dn, field)
    end

    def search(args = {})
      self.run_search(args)
    end

    def bind_as(args = {})
      if !args[:filter]
        password = args.delete(:password)
        search_args = ActiveDirectory::LDAP::SearchArgs.new(args)
        args[:filter] = search_args[:filter]
        args[:password] = password
      end
      !!self.run(:bind_as, args)
    end

    protected

    def run_search(args)
      search_args = ActiveDirectory::LDAP::SearchArgs.new(args)
      if !self.settings.search_size_supported
        size = search_args.delete(:size)
      end
      results = (self.run(:search, search_args) || [])
      if !self.settings.search_size_supported && size && results.kind_of?(Array)
        results[0..(size.to_i - 1)]
      else
        results
      end
    end

    # Inspired by https://github.com/tpett/perry logger
    def run(method, *args)
      result, time = [ nil, -1 ]
      if self.run_commands
        time = (Benchmark.measure do
          result = self.adapter.send(method, *args)
        end).real
      end
      self.logger.out(method, args, result, time)
      result
    rescue Exception => exception
      self.logger.out(method, args, result, time)
      raise(exception)
    end

  end

end
