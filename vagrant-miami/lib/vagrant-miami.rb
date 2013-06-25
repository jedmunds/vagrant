module VagrantGemPlugin
  class Plugin < Vagrant.plugin("2")
    name "Miami"

    command "miami" do
      require_relative "vagrant-miami/command"
      Command
    end
  end

  # The source root is the path to the root directory of
  # the plugin gem.
  def self.source_root
    @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
  end

  # Default I18n to load the en locale
end
