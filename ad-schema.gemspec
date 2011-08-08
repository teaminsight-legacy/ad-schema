# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "active_directory/version"

Gem::Specification.new do |s|
  s.name        = "ad-schema"
  s.version     = ActiveDirectory::VERSION
  s.authors     = ["jcredding"]
  s.email       = ["TempestTTU@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}
  
  s.add_dependency("net-ldap",          ["~> 0.2.2"])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
