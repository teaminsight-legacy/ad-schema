# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ad-schema/version"

Gem::Specification.new do |s|
  s.name        = "ad-schema"
  s.version     = AD::Schema::VERSION
  s.authors     = ["Collin Redding", "Matt McPherson"]
  s.homepage    = "http://github.com/teaminsight/ad-schema"
  s.summary     = %q{A gem that models active directory's schema and provides a friendlier interface for reading and modifying data.}
  s.description = %q{A gem that models active directory's schema and provides a friendlier interface for reading and modifying data.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "ad-framework", "~>0.1.0"

  s.add_development_dependency "assert",  "~>0.2.0"
  s.add_development_dependency "log4r",   "~>1.1.9"
  s.add_development_dependency "mocha",   "~>0.9.12"
end
