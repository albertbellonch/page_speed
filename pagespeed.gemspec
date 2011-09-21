# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pagespeed/version"

Gem::Specification.new do |s|
  s.name        = "pagespeed"
  s.version     = Pagespeed::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Albert Bellonch"]
  s.email       = ["albert@itnig.net"]
  s.homepage    = ""
  s.summary     = %q{-}
  s.description = %q{-}

  s.rubyforge_project = "pagespeed"

  s.bindir             = 'bin'
  s.executables        = ['pagespeed']
  s.default_executable = 'pagespeed'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.add_dependency "thor"
  s.add_development_dependency "rspec", "2.3.0"
  s.add_development_dependency "ZenTest", "4.4.2"
end
