# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "piano/version"

Gem::Specification.new do |s|
  s.name        = "piano"
  s.version     = Piano::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Xavier Via"]
  s.email       = ["xavierviacanel@gmail.com"]
  s.homepage    = "http://github.com/xaviervia/piano"
  s.summary     = %q{Out-of-the-box sinatra server for web site sketching using haml + sass + coffee-script}
  s.description = %q{Out-of-the-box sinatra server for web site sketching using haml + sass + coffee-script}

  s.rubyforge_project = "piano"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
