# -*- mode: ruby -*-
# vi: set ft=ruby :
# Hopefully, this Vagrantfile will work like the 1.0 one did, with shelters
# and all those goodies. I will be trying to fix what was always broken but
# I never saw, and I'm crying on the inside right now.

require 'yaml'

Vagrant.configure("2") do |config|
  begin
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
    if ARGV[0] == 'up' or ARGV[0] == 'destroy' or ARGV[0] == 'provision' or
      ARGV[0] == 'halt' or ARGV[0] == 'resume' or ARGV[0] == 'reload' or
      ARGV[0] == 'ssh'
      $environ = ARGV[1]
      ARGV.each do |argument|
        if argument == "--provider=aws"
          $use_aws = true
        end
      end
      ARGV.delete_at(1)
    end

    if $environ == nil then $environ == 'default' end
    # If the user did not pass a second argument, just set the box name to
    # 'default'

    $global_config = {}

    y = YAML.load_file("shelters.yaml")

    y["environ"].each do |small_hash|
      if small_hash.keys[0] == "global_defaults"
        global_conf_array = y["environ"][0]["global_defaults"]
        global_conf_array.each do |gconf|
          $global_config[gconf.keys[0]] = gconf.values[0]
        end
      end
      # Set the global configurations based on the external YAML file.
      # This should not need to be modified, it will pull everything
      # from the "global_defaults" key

      if small_hash.keys[0] == $environ
        $vm_names = small_hash.values[0]
      end
      # Get the names of the virtual machines we want to bring up. This is the
      # core of the 'shelters' concept. Three lines of code. I like it.

    end

    if $vm_names == nil
      $vm_names = []
      $vm_names.push($environ)
      if ARGV[0] == 'up'
        puts "WARNING: You are bringing up a VM not defined in the shelters.yaml
        file. The box will continue to load, but provisioning will not be applied
        unless it is defined in your vagrant.pp equivalent."
      end
    end
    # If the virtual machine name is not defined in the shelters.yaml file, it will
    # continue to load it and the box will complete successfully. However, it will
    # only provision if the box hostname is included in the vagrant.pp file.
    begin
    
      # For though I walk in the shadow of not being able to mutilate the Vagrantfile
      # in any way I Want, I will fear no Evil, for Google is with me. It's search 
      # feature and ability to find anything I need, they comfort me.

      config.vm.define :vm do |vm_config|
        vm_config.vm.box = "centos6-64-puppet"
      end

    rescue Exception => ex
      puts "There was an error configuring the Virtual Machine.. The error message
      is below\n" + e.message + e.backtrace.inspect
    end


  rescue Exception => e
    puts "There was an error in the program." + e.message + "\n" + 
          e.backtrace.inspect
  end
end

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "init.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
