require "vagrant"

module VagrantPlugins
  module CommandShelters
    class Shelter < Vagrant.plugin("2")
      name "Shelters"
      description <<-DESC
      The 'shelter' command sets up your working directory
      to be something other than the working directory.
      DESC

      command("shelter") do
        require File.expand_path("../command", __File__)
        Command
      end
    end
  end
end
