begin
  require "vagrant"
  require "optparse"
  require "vagrant/util/template_renderer"
rescue LoadError
  raise "The Vagrant Shelters plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to 
# install this into an early Vagrant Version.
if Vagrant::VERSION < "1.2.0"
  raise "The Vagrant Shelters plugin is only compatible with Vagrant 1.2+"
end

module VagrantPlugins
  module VagrantShelters
    class Shelter < Vagrant.plugin("2")
      name "Shelters"
      description <<-DESC
      This plugin installs (hopefully) the ability to use
      Vagrantfiles outside the working directory
      DESC

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: vagrant shelter [path-name]"
      end

      # Parse the options
      argv = parse_options(opts)
      return if !argv

      save_path = @env.cwd.join("Vagrantfile")
      raise Vagrant::Errors::VagrantfileExistsError if save_path.exist?

      template_path = ::Vagrant.source_root.join("templates/commands/shelter/Vagrantfile")
      contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                      :box_name => argv[0] || "base",
                                                      :box_url => argv[1])
      # Write out the contents
      save_path.open("w+") do |f|
        f.write(contents)
      end

      @env.ui.info(I18n.t("vagrant.commands.shelter.success"),
                  :prefix => false)

      # Success, exit status 0
      0
    end
  end
end
