# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "piano/version"

Gem::Specification.new do |s|
  s.name        = "piano"
  s.version     = Piano::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Xavier Via"]
  s.email       = ["xavierviacanel@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Write a gem summary}
  s.description = %q{Write a gem description}

  s.rubyforge_project = "piano"
  s.add_dependency "sinatra"
  s.add_dependency "haml"
  s.add_dependency "sass"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
