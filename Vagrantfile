# This is a unique Vagrantfile, somewhat 'hacked' together, written by Jordan
# Edmunds. It parametizes the creation of vagrant machines and loops through
# a set of predefined machine environments, if the one you specify does not
# exist, it sets it up. For instance, running vagrant up confluence brings up
# two VM's, the confluence master, and the 'wiki' box. I will try to document
# this Vagrantfile as much as I can, hopefully it should be easy enough to 
# edit.

require 'yaml'
require 'open-uri'

begin
# I don't see the below working in a system-independent user-oblivious sort of way anytime soon,
# will just force people to download the YAML file with the Vagrantfile

#  if File.exist?('shelters.yaml') == false or File.read('shelters.yaml') == ""
#    File.open('shelters.yaml', 'wb') do |saved_file|
#      open("http://raw.github.com/jedmunds/vagrant/master/shelters.yaml", 'rb') do |read_file|
#        saved_file.write(read_file.read)
#      end
#    end
#  end
rescue Exception => e
  puts "There was an error when downnloading the shelters.yaml file:\n" + e.message + "\n" +
        e.backtrace.inspect
end
  # Tests to see if the shelters.yaml file is in the same directory, if not it 
  # pulls down one from my github.
@global_config = {}   
begin 
  Vagrant::Config.run do |config|
  
    if ARGV[0] == 'up' or ARGV[0] == 'destroy' or ARGV[0] == 'provision' or ARGV[0] == 'halt' or
       ARGV[0] == 'resume' or ARGV[0] == 'reload' or ARGV[0] == 'ssh'
      $environ = ARGV[1]
      ARGV.delete_at(1)
    end
    # Gets the argument typed after 'vagrant up', normally the machine name, and 
    # puts it into a global variable called $environ.
  
    # if ARGV[1].empty? == false
    #   puts "HELLO WORLD"
    # end
    # It is possible to test the first, second, third, or umpteenth argument with
    # the above code. All of ruby's powerful String methods are available to use.
    # This would be the equivalent of writing a plugin or adding an additional 
    # (albeit undocumented) command to vagrant.
  
    y = YAML.load_file("shelters.yaml")  

    y["environ"].each do |small_hash|
      if small_hash.keys[0] == "global_config"
        global_conf_array = y["environ"][0]["global_config"]
        global_conf_array.each do |config|
          @global_config["#{config.keys[0]}"] = config.values[0]
        end
      end
    # This writes the global variables defined in our config.yaml file, we can load
    # absolutely anything we want. In this case, I believe, there are about 6 different
    # variables loaded

      if small_hash.keys[0] == $environ
        @vm_names = small_hash.values[0]
      end
    end
    # The above is a somewhat-messy way of extracting the raw text in array form
    # from the YAML file we load from. You should never need to edit this, I will
    # make it more efficient and clear as I figure out how to code in ruby...
    # But basically it loops through to find the matching environment and extracts
    # the list of machines to spin up. Will support multiple environments 
    # eventually.,

    if @vm_names == nil
      @vm_names = []
      if $environ == nil      # if a different command is being run, $environ still needs a value
        $environ = 'default'
      end
      @vm_names.push($environ) # makes sure our Vagrantfile doesn't interfere with other things
      if ARGV[0] == 'up'
        puts "Warning: You are bringing up a VM not defined in the shelters.yaml file. If you
          are missing the shelters.yaml file, you may download it on github, at
          'https://raw.github.com/jedmunds/vagrant/master/shelters.yaml'"
      end
    end
    # If the name specified was not in the VM list in the shelters.yaml file, bring
    # up a VM with the name requested.

      begin
        @vm_names.each do |vm|
          vm_name = vm
          vm_config = vm_name + "_config"
          # the vm_name variable may be unnecessary, and can just be accessed by
          # calling to vm. However, I had quite a fun time trying to debug that,
          # and I would suggest leaving it there for now.
    
          eval %Q( # This allows us to pass in variable names in config.vm.define
            config.vm.define :#{vm_name} do |#{vm_config}|
    
              # NOTE - THE BELOW LINES ARE NOT COMMENTED OUT, THEY ARE REFERENCING VARIABLES
              #{vm_config}.vm.box = @global_config["default_box"]
              #{vm_config}.vm.box_url = @global_config["default_box_url"]
    
              #{vm_config}.vm.network :hostonly, "#{@global_config["ip_network"]}21"
    
              #{vm_config}.vm.host_name = "#{@global_config["default_hostname"]}#{vm_name}#{@global_config["default_network"]}"
    
              #{vm_config}.vm.share_folder "puppet", "/home/vagrant/puppet_bootstrap", "." 
    
              #{vm_config}.vm.provision :#{@global_config["default_provisioner"]} do |#{@global_config["default_provisioner"]}|
                #{@global_config["default_provisioner"]}.manifests_path = @global_config["default_manifests_path"]
                #{@global_config["default_provisioner"]}.manifest_file = @global_config["default_manifests_file"]
                #{@global_config["default_provisioner"]}.module_path = @global_config["default_module_path"]
              end 
            end
          )
        end
      rescue Exception => e
      puts "There was an error when trying to bring up the VM's:\n" + e.message + "\n" +
            e.backtrace.inspect
      end
    config.ssh.private_key_path="~/edmunds_dev/vagrantpriv"
  end
rescue Exception => e
  puts "There was an error somewhere in Vagrant::Config" + e.message + "\n" +
        e.backtrace.inspect
end

  # SSH private key
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "centos6-base"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file centos6-base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 064    }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "centos6-base.pp"
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
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
