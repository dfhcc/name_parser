# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "name_parser/version"

Gem::Specification.new do |s|
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ruby-debug19'
  s.name        = "name_parser"
  s.version     = NameParser::VERSION
  s.authors     = ["Chris Pallotta", "Scott Pullen", "Tom Leonard"]
  s.email       = ["ChristopherF_Pallotta@dfci.harvard.edu", "ScottT_Pullen@dfci.harvard.edu", "Thomas_Leonard@dfci.harvard.edu"]
  s.homepage    = ""
  s.summary     = %q{Parses strings.}
  s.description = %q{Parses particular kinds of strings. For now, it only handles parsing people names.}

  s.rubyforge_project = "name_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec"
  
  # s.add_runtime_dependency "rest-client"
end
