# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gem-this}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Adam"]
  s.date = %q{2009-12-21}
  s.default_executable = %q{gem-this}
  s.email = %q{james@lazyatom.com}
  s.executables = ["gem-this"]
  s.files = ["Rakefile", "Readme.markdown", "Rakefile.erb", "bin/gem-this", "lib/gem_this.rb", "lib/rubygems_plugin.rb"]
  s.homepage = %q{http://github.com/lazyatom/gem-this}
  s.require_paths = ["bin", "lib"]
  s.rubyforge_project = %q{gem-this}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Make existing code into a gem, without any fuss.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
