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
  s.add_dependency "sinatra", ">= 1.2.6"
  s.add_dependency "sinatra-flash", ">= 0.3.0"
  s.add_dependency "haml", ">= 3.1.1"
  s.add_dependency "sass", ">= 3.1.1"
  s.add_dependency "compass", ">= 0.12.2"
  s.add_dependency "coffee-script", ">= 2.2.0"
  s.add_dependency "i18n", ">= 0.6.0"
  s.add_dependency "metafun"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
