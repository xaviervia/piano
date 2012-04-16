# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "metafun/version"

Gem::Specification.new do |s|
  s.name        = "metafun"
  s.version     = Metafun::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Xavier Via"]
  s.email       = ["xavier.via.canel@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A library for extending Ruby native metaprogramming capabilities}
  s.description = %q{A library for extending Ruby native metaprogramming capabilities}

  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"

  s.rubyforge_project = "metafun"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
