# -*- coding: utf-8 -*-
require 'erb'
require 'etc'

class GemThis
  SUMMARY = "Creates a Rakefile suitable for turning the current project into a gem."
  DEBUG_MESSAGE = "debug, only prints out the generated Rakefile."

  attr_reader :name, :debug

  def initialize(name, options={})
    @name = name
    options = {:default => false, :silent => false}.update(options)
    @debug = options[:debug]
    @silent = options[:silent]
  end

  def create_rakefile
    template = ERB.new File.read(File.join(File.dirname(__FILE__), '..', 'Rakefile.erb')), nil, '<>'
    rakefile = template.result(binding)

    if debug
      puts rakefile
    else
      if File.exist?('Rakefile')
        log "Appended to existing Rakefile"
        File.open('Rakefile', 'a') { |f| 2.times { f.puts }; f.write rakefile }
      else
        log "Writing new Rakefile"
        File.open('Rakefile', 'w') { |f| f.write rakefile }
      end
      add_to_gitignore if using_git?
    end
    unless has_lib_directory?
      log "You don't seem to have a lib directory - please edit the Rakefile to set where your code is."
      false
    end
  end

  private

  def log(message)
    puts(message) unless @silent
  end

  def author_name
    Etc.getpwnam(ENV['USER']).gecos rescue ENV['USER'] # for Windows
  end

  def author_email
    email = ''

    # even if using git, author may not have specified email address
    if using_git?
      email = %x{git config --get user.email}.strip
    end

    email == '' ? "youremail@example.com" : email
  end

  def author_url
    "http://yoursite.example.com"
  end

  def using_rspec?
    File.directory?('spec')
  end

  def using_cucumber?
    File.directory?('features')
  end

  def using_test_unit?
    File.directory?('test')
  end

  def has_executables?
    File.directory?('bin')
  end

  def has_lib_directory?
    File.directory?("lib")
  end

  def dirs_to_include_glob
    dirs = %w(bin test spec lib).select { |d| File.directory?(d) }
    if dirs.any?
      dirs.join(",") + "/**/*"
    else
      "**/*"
    end
  end

  def readme
    Dir['*'].find { |f| f =~ /readme/i }
  end

  def files_in_root
    Dir['*'].reject { |f| File.directory?(f) }.join(" ")
  end

  def using_git?
    File.exist?(".git")
  end

  def default_tasks
    tasks = []
    tasks << "test" if using_test_unit?
    tasks << "spec" if using_rspec?
    tasks << "features" if using_cucumber?
    tasks
  end

  def development_dependencies
    deps = []
    deps << "rspec" if using_rspec?
    deps << "cucumber" if using_cucumber?
    deps
  end

  def add_to_gitignore
    return unless File.exist?(".gitignore")
    ignores = File.readlines(".gitignore")
    ignores += ["pkg", "rdoc"]
    File.open(".gitignore", "w") { |f| f.write ignores.map { |l| l.strip }.uniq.join("\n") }
  end
end
