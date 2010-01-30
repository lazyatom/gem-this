require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs = [File.expand_path("lib"), "test"]
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

# This builds the actual gem. For details of what all these options
# mean, and other ones you can add, check the documentation here:
#
#   http://rubygems.org/read/chapter/20
#
spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "gem-this"
  s.version           = "0.3.2"
  s.summary           = "Make existing code into a gem, without any fuss."
  s.author            = "James Adam"
  s.email             = "james@lazyatom.com"
  s.homepage          = "http://github.com/lazyatom/gem-this"

  s.has_rdoc          = true
  # s.extra_rdoc_files  = %w(Readme.markdown)
  # s.rdoc_options      = %w(--main Readme.markdown)

  # Add any extra files to include in the gem
  s.files             = %w(Rakefile Readme.markdown Rakefile.erb) + Dir.glob("{bin,lib}/**/*")
  s.executables       = FileList["bin/**"].map { |f| File.basename(f) }
  s.require_paths     = ["bin", "lib"]

  # If you want to depend on other gems, add them here, along with any
  # relevant versions
  # s.add_dependency("some_other_gem", "~> 0.1.0")

  # If your tests use any gems, include them here
  s.add_development_dependency("shoulda")
  s.add_development_dependency("rspec")
  s.add_development_dependency("cucumber")

  # If you want to publish automatically to rubyforge, you'll may need
  # to tweak this, and the publishing task below too.
  s.rubyforge_project = "gem-this"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3")
end

# This task actually builds the gem. We also regenerate a static
# .gemspec file, which is useful if something (i.e. GitHub) will
# be automatically building a gem for this project. If you're not
# using GitHub, edit as appropriate.
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec

  # Generate the gemspec file for github.
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

# Generate documentation
Rake::RDocTask.new do |rd|
  rd.main = "Readme.markdown"
  rd.rdoc_files.include("Readme.markdown", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end

# If you want to publish to RubyForge automatically, here's a simple
# task to help do that. If you don't, just get rid of this.
# Be sure to set up your Rubyforge account details with the Rubyforge
# gem; you'll need to run `rubyforge setup` and `rubyforge config` at
# the very least.
begin
  require "rake/contrib/sshpublisher"
  namespace :rubyforge do

    desc "Release gem and RDoc documentation to RubyForge"
    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]

    namespace :release do
      desc "Release a new version of this gem"
      task :gem => [:package] do
        require 'rubyforge'
        rubyforge = RubyForge.new
        rubyforge.configure
        rubyforge.login
        rubyforge.userconfig['release_notes'] = spec.summary
        path_to_gem = File.join(File.dirname(__FILE__), "pkg", "#{spec.name}-#{spec.version}.gem")
        puts "Publishing #{spec.name}-#{spec.version.to_s} to Rubyforge..."
        rubyforge.add_release(spec.rubyforge_project, spec.name, spec.version.to_s, path_to_gem)
      end

      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = "/var/www/gforge-projects/gem-this/" # Should be the same as the rubyforge project name
        local_dir = 'rdoc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end
