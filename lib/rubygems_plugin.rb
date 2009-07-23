require 'rubygems/command_manager' 
require 'rubygems/command'
 
class Gem::Commands::ThisCommand < Gem::Command
  def initialize
    super 'this', "Creates a Rakefile suitable for turning the current project into a gem."
  end
  
  def execute
    `gem-this`
  end
end

Gem::CommandManager.instance.register_command :this
