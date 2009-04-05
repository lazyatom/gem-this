# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gem-this}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Adam"]
  s.date = %q{2009-04-05}
  s.default_executable = %q{gem-this}
  s.email = %q{james@lazyatom.com}
  s.executables = ["gem-this"]
  s.files = ["Rakefile", "Readme.markdown", "bin/gem-this"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/lazyatom/gem-this}
  s.require_paths = ["bin"]
  s.rubyforge_project = %q{gem-this}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Make existing code into a gem, without any fuss.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
