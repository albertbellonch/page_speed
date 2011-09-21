# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "page_speed/version"

Gem::Specification.new do |s|
  s.name        = "page_speed"
  s.version     = PageSpeed::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Albert Bellonch"]
  s.email       = ["albert@itnig.net"]
  s.homepage    = "http://itnig.net"
  s.summary     = %q{A simple port for Google Page Speed's scores}
  s.description = %q{-}

  s.rubyforge_project = "page_speed"

  s.bindir             = 'bin'
  s.executables        = ['page_speed']
  s.default_executable = 'page_speed'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec", "2.3.0"
  s.add_development_dependency "ZenTest", "4.4.2"
end
