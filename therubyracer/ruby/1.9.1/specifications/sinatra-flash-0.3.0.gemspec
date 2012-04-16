# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sinatra-flash"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Eley"]
  s.date = "2010-05-02"
  s.description = "A Sinatra extension for setting and showing Rails-like flash messages. This extension improves on the Rack::Flash gem by being simpler to use, providing a full range of hash operations (including iterating through various flash keys, testing the size of the hash, etc.), and offering a 'styled_flash' view helper to render the entire flash hash with sensible CSS classes. The downside is reduced flexibility -- these methods will *only* work in Sinatra."
  s.email = "sfeley@gmail.com"
  s.extra_rdoc_files = ["LICENSE.markdown", "README.markdown"]
  s.files = ["LICENSE.markdown", "README.markdown"]
  s.homepage = "http://github.com/SFEley/sinatra-flash"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "Proper flash messages in Sinatra"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<sinatra-sessionography>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<sinatra-sessionography>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 1.0.0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<sinatra-sessionography>, [">= 0"])
  end
end
