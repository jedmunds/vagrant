# This is a unique Vagrantfile, somewhat 'hacked' together, written by Jordan
# Edmunds. It parametizes the creation of vagrant machines and loops through
# a set of predefined machine environments, if the one you specify does not
# exist, it sets it up. For instance, running vagrant up confluence brings up
# two VM's, the confluence master, and the 'wiki' box. I will try to document
# this Vagrantfile as much as I can, hopefully it should be easy enough to 
# edit.

require 'rbconfig'
require 'yaml'
require 'open-uri'
  begin
  if File.exist?('shelters.yaml') == false
    open('shelters.yaml', 'wb') do |fo|
      fo.print open('https://raw.github.com/jedmunds/vagrant/master/shelters.yaml').read
    end
  end
  rescue Exception => e
  puts "There was an error when downnloading the shelters.yaml file:\n" + e.message + "\n" +
        e.backtrace.inspect
  end
  # Tests to see if the shelters.yaml file is in the same directory, if not it 
  # pulls down one from my github.
    
  
  Vagrant::Config.run do |config|
  
    $environ = ARGV[1]
    ARGV.delete_at(1)
    # Gets the argument typed after 'vagrant up', normally the machine name, and 
    # puts it into a global variable called $environ.
  
    # if ARGV[1].empty? == false
    #   puts "HELLO WORLD"
    # end
    # It is possible to test the first, second, third, or umpteenth argument with
    # the above code. All of ruby's powerful String methods are available to use.
    # This would be the equivalent of writing a plugin or adding an additional 
    # (albeit undocumented) command to vagrant.
  
    @ip_addrs = { "confluence_master" => "20",
                  "confluence_wiki" => "21",
                }
  
    big_array = YAML.load_file("shelters.yaml")["environ"]
  
    big_array.each do |small_hash|
      if small_hash.keys[0] == $environ
        @vm_names = small_hash.values[0]
      end
    end
  
    # The above is a somewhat-messy way of extracting the raw text in array form
    # from the YAML file we load from. You should never need to edit this, I will
    # make it more efficient and clear as I figure out how to code in ruby...
    # But basically it loops through to find the matching environment and extracts
    # the list of machines to spin up. Will support multiple environments 
    # eventually.
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
              #{vm_config}.vm.box = "centos6-64-puppet" 
              #{vm_config}.vm.box_url = 'http://srsdcllhttp01/basebox/centos6-64-puppet.box'
    
              #{vm_config}.vm.network :hostonly, "10.99.0.#{@ip_addrs["#{$environ}_#{vm_name}"]}"
              # I know the above looks a little awkward, but it is the most easy way to find
              # a unique IP address for each VM.
    
              #{vm_config}.vm.host_name = "vagrant-puppet-#{vm_name}.pv.com"
    
              #{vm_config}.vm.share_folder "puppet", "/home/vagrant/puppet_bootstrap", "." 
    
              #{vm_config}.vm.provision :puppet do |puppet|
                puppet.manifests_path = '../edmunds_dev/manifests'
                puppet.manifest_file = 'vagrant.pp'
                puppet.module_path = '../edmunds_dev/modules'
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
