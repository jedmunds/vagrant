# -*- mode: ruby -*-
# vi: set ft=ruby :
# SUCCESS! This is a cross-platform Vagrantfile that fully parameterizes
# all Vagrant settings. For more extensive documentation, please visit
# https://pvwiki.pv.com/display/OPS/NeoVagrant

require 'yaml'

Vagrant.configure("2") do |config|

# LOGIC FLOW OF THIS SCRIPT - Please adhere to this or change it
# 1. READING PARAMETERS PASSED IN FROM COMMAND LINE
# 2. ASSIGNING GLOBAL ENVIRONMENT VARIABLES BASED ON THOSE PARAMETERS
# 3. READING YAML FILE CONFIGURATION AND WRITING THAT TO GLOBAL VARIABLES.
# 4. MAKE SURE THE SYNTAX WILL NOT BLOW THINGS UP
# 5. WRITE THE UPPED OR DESTROYED VM'S TO SHELTERS.YAML
# 6. CHECK FOR OVERRIDES OF GLOBAL CONFIG VARIABLES
# 7. CONFIGURE THE VIRTUAL MACHINES WITH THE GLOBAL VARIABLES OR OVERRIDES 
# 8. SUPPORT FOR MULTI-PROVIDER ENVIRONMENTS IS IMPLEMENTED

  begin
    begin
      $gc = {}
      $gc["vm_names"] = []
      $gc["vm_ips"] = {}
      # These are the really important global variables referenced throughout
      # this document, originally I didn't declare them but that led to some
      # pretty unpredictable behaviour... I would leave these in peace

      if ARGV[0] == 'up' or ARGV[0] == 'destroy' or ARGV[0] == 'provision' or
        ARGV[0] == 'halt' or ARGV[0] == 'resume' or ARGV[0] == 'reload' or
        ARGV[0] == 'ssh' or ARGV[0] == 'status' or ARGV[0] == 'suspend'
        if ARGV[1] == nil
          ARGV[1] = 'all'
        end
        # If they run 'vagrant status', they mean 'vagrant status all' for this
        # Vagrantfile. This code is to fix a bug I had previously where running
        # any vagrant command would delete the 2nd argument. This was a problem
        # for stuff like 'vagrant plugin install'

        $environ = ARGV[1]
        # Assigns the variable $environ to ARGV[1], or the second argument after
        # 'vagrant', where 'up' would be the first argument.

        ARGV.each do |argument|
          if argument == "--provider=aws" or argument == "provider=vsphere"
            if ARGV[0] != "up" then ARGV.delete_at(1) end
            if argument == "--provider=aws"then $gc["provider"] = "aws"
            elsif argument == "--provider=vsphere" then $gc["provider"] = "vsphere"
            end
          else $gc["provider"] = "virtualbox"
          end
        end
        # This is something of a workaround to ensure that if they specified 
        # --provider=aws, to bring up virtual machines in AWS, or modify them.

        ARGV.delete_at(1)
        # This deletes the name of the vagrant machine environment so we can put
        # in our own stuff, found this sucker on stackoverflow.com. Love that 
        # site.

      end
    rescue Exception => er
      puts "There was an error processing the arguments.\n\n" + e.message +
      "\n" + e.backtrace.inspect
    end


    begin
      # Loads the YAML file from the current directory

      def getDefaults()
        y = YAML.load_file("shelters.yaml")
        y["environ"].each do |small_hash|
          if small_hash.keys[0] == "global_defaults"
            global_conf_array = y["environ"][0]["global_defaults"]
            global_conf_array.each do |gconf|
              $gc[gconf.keys[0]] = gconf.values[0]
            end
          end
        end
      end
      getDefaults()
      # Set the global configurations based on the external YAML file.
      # This should not need to be modified, it will pull everything
      # from the "global_defaults" key

      y = YAML.load_file("shelters.yaml")
      y["environ"].each do |small_hash|
        if small_hash.keys[0] == "shelters"
          small_hash.values[0].each do |smaller_hash|
            if smaller_hash.keys[0] == $environ     # ie. "confluence"
              if smaller_hash.values[0][0].class == Hash
                smaller_hash.values[0].each do |os_name|
                  $gc["vm_names"].push(os_name.keys[0])
                  $gc["vm_ips"][os_name.keys[0]] = os_name.values[0][0]["ip"]
                end
              end
            end
            if $environ == 'all'
              smaller_hash.values[0].each do |os_name|
                $gc["vm_names"].push(os_name.keys[0])
                $gc["vm_ips"][os_name.keys[0]] = os_name.values[0][0]["ip"]
              end
            end
            # If the user did not specify a virtual machine name, give them all
            # the names in the shelters.yaml file. This is about 30 VM's as of
            # writing

          end
        end
        # Get the names of the virtual machines we want to bring up. This is the
        # core of the 'shelters' concept. Also assign the ip's we are going to use
        # based on the YAML configuration. This writes the vm names to an array
        # called $vm_names and the ip's to a hash called $vm_ips

      end

    rescue Exception => ey
      puts "There was an error loading information from the YAML file.\n\n" + 
      ey.message + "\n\n" + ey.backtrace.inspect
    end

    begin
      if $gc["vm_names"] == []
        $gc["vm_names"].push($environ)
        $gc["vm_ips"][$environ] = '8'
        # If no name was found in the shelters.yaml file, push the name provided directly
        # from the vagrant up command.

        if ARGV[0] == 'up'
          puts "WARNING: You are bringing up a VM not defined in the shelters.yaml
          file. The box will continue to load, but provisioning will not be applied
          unless it is defined in your vagrant.pp equivalent."
        end
      end
      # If the virtual machine name is not defined in the shelters.yaml file, it will
      # continue to load it and the box will complete successfully. However, it will
      # only provision if the box hostname is included in the vagrant.pp file.

    rescue Exception => eass
      puts "There was an error assigning a custom VM name to vagrant. This should never" +
      " happen."
    end

    begin
    
      # For though I walk in the shadow of not being able to mutilate the Vagrantfile
      # in any way I Want, I will fear no Failure, for Google is with me. It's search 
      # feature and ability to find anything I need, they comfort me. And we begin.
      
      $gc["vm_names"].each do |vm|
      # For each value found in $vm_names, make a new virtual machine. It is this loop
      # that allows us to use 'shelters' with multiple vagrant machines. DONT TOUCH.
        if ARGV[0] == 'up'
          y['WORKING'][vm] = {}
          y['WORKING'][vm]['provider'] = $gc['provider']
          y['WORKING'][vm]['ip'] = $gc['vm_ips'][vm]
        elsif ARGV[0] == 'provision' or
          ARGV[0] == 'halt' or ARGV[0] == 'resume' or ARGV[0] == 'reload' or
          ARGV[0] == 'ssh' or ARGV[0] == 'status' or ARGV[0] == 'suspend'
          if defined? y['WORKING'][vm]['provider'] == 'aws' then $gc['provider'] = 'aws' end 
        elsif ARGV[0] == 'destroy'
          if defined? y['WORKING'][vm]['provider'] == 'aws' then $gc['provider'] = 'aws' end
          y['WORKING'].delete('swag')
        end
        File.open("shelters.yaml", 'w') { |f| YAML.dump(y, f) }
        # The above will write to the YAML file when you up or destroy a VM, and shows
        # critical information such as the provider and the ip. It also checks the 
        # provider of the upped vm's so you don't have to append --provider="providername"
        # to all commands involving those VM's

        is_environ = false
        # This variable lets us check to see if the user is trying to 'up' an environment
        # or just a single machine within those environments

        y["environ"][1]["shelters"].each do |environment|
          if environment.keys[0] == $environ
            is_environ = true
            environment.values[0].each do |machine|
              if machine.keys[0] == vm
                machine.values[0].each do |option|
                  $gc[option.keys[0]] = option.values[0]
                end
              end
            end
          end
        end
        # This is where we check for global overrides for each component of the box.
        # Note: This method, while elegant, also adds in a couple unused items to $gc
        # as of right now.

        if is_environ == false
          y["environ"][1]["shelters"].each do |environment|
            environment.values[0].each do |machine|
              if machine.keys[0] == vm
                machine.values[0].each do |option|
                  $gc[option.keys[0]] = option.values[0]
                end
              end
            end
          end
        end
        # I had to add this in in case they wanted a specific box within the shelters,
        # because without this above loop it would override the defaults for every box
        # with the same name under different shelters, leading to unpredictable
        # behaviour (and yes I spelled that the British way.)

        config.vm.define vm.to_sym do |vm_config|
          vm_config.vm.box = $gc["box"]
          vm_config.vm.box_url = $gc["box_url"]
          # Basic configuration for VM boxes. Please change the values in shelters.yaml,
          # don't hardcode them in here. You could seriously mess something up.
          
          #vm_config.vm.provision :shell, :path => "../bootstrap.sh"

          vm_config.vm.network $gc["network_type"].to_sym, ip: "#{$gc["ip_network"]}#{$gc["vm_ips"][vm]}"
          vm_config.vm.hostname = "#{$gc["hostname"]}#{vm}#{$gc["hostname_network"]}"
          vm_config.vm.synced_folder $gc["sync_folder_host"], $gc["sync_folder_guest"]
          # Sets up the networking-related stuff, including synced folders (used to be shared)
          # and sets up the IP's defind in shelters.yaml


          vm_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = $gc["manifests_path"]
            puppet.manifest_file = $gc["manifests_file"]
            puppet.module_path = $gc["module_path"]
          end
          # Configures the provisioner for this VM. Note on this - it should be parameterized in
          # the future to have vm_config.vm.provision :$gc["provider"] in the future, I'm just
          # having issues for some reason at the moment.

          if $gc["provider"] == "aws"
          # If the user specified --provider=aws, then interact with the VM's through amazon's
          # AWS service rather than VirtualBox. Support should be added for $use_vSphere as well
          # in the future below here.

            vm_config.vm.provider :aws do |aws, override|
              aws.access_key_id = $gc["aws_access_key_id"]
              aws.secret_access_key = $gc["aws_secret_access_key"]
              aws.keypair_name = $gc["aws_keypair_name"]
              # Sets up the AWS defaults, really guys you should NOT be touching this D:

              aws.ami = $gc["aws_ami"]
              aws.region = $gc["aws_region"]
              aws.instance_type = $gc["aws_instance_type"]
              # More stuff you really shouldn't touch, just edit the YAML file.

              aws.user_data = "#!/bin/bash\necho 'Defaults:ec2-user !requiretty' > /etc/sudoers.d/999-vagrant-cloud-init-requiretty && chmod 440 /etc/sudoers.d/999-vagrant-cloud-init-requiretty\nhostname vagrant-puppet-minimal.pv.com"
              # The above is a somewhat-sketchy workaround for rsyncing folders in vagrant.
              # A better fix is to load an external text file with similar stuff. An even
              # BETTER fix is to create a custom AMI that has a user with the proper permissions.
              
              aws.security_groups = [$gc["aws_security_groups"]]
              # aws.subnet_id = $gc["subnet_id"]
              # The above configuration is specific to our VPC, and I will try to get it working
              # ASAP. 

              override.ssh.username = $gc["aws_username"]
              override.ssh.private_key_path = $gc["aws_private_key_path"]
              # global overrides for the AWS username and private key

            end
          end

          if $gc["provider"] == "vsphere"
            # Nothing has been done here yet, I still need our vSphere information from Wilson/Eric

          end
          getDefaults()
        end
      end

    config.ssh.private_key_path = $gc["private_key_path"]

    rescue Exception => ex
      puts "There was an error configuring the Virtual Machine.. The error message
      is below\n" + e.message + e.backtrace.inspect
    end


  rescue Exception => e
    puts "Well, this is embarrassing.. There may have been an error in the program."
  end
end

# I deleted all the annoying and now-unnecessary messages from our good mitchellh at the bottom,
# If you need to add functionality it's much easier to google it. Hope this Vagrantfile was useful.
# a Jordan Edmunds, Packet Video 2013.
