require "rubygems"
require "rubygems/gem_runner"

require "vagrant/util/safe_puts"

module VagrantGemPlugin
	# this code is basically just coped from:
	# https://github.com/mitchellh/vagrant/blob/v1.0.7/lib/vagrant/command/gem.rb

  class Command < Vagrant.plugin(2, :command)
    include Vagrant::Util::SafePuts

    def execute
      # Bundler sets up its own custom gem load paths such that our
      # own gems are never loaded. Therefore, give an error if a user
      # tries to install gems while within a Bundler-managed environment.
      puts "hello"
    end
  end
end
