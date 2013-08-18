Vagrant?
=======

Vagrant is a 'wrapper' for many different virtual machine providers, in other words, it is a single solution to spin up virtual machines from the command line with programs like virtualbox, or cloud-based services like amazon's EC2 or VMWare's vSphere. Easily bootstrap and provision machines with a single command! Please, developers, make your life easy. Check it out! http://vagrantup.com. 

Welcome to a new way of using vagrant, flexible and fully parameterized.

<h2>Vagrantfile</h2>
This file would normally be auto-generated by Vagrant, but with some heavy-duty ruby lifting, this Vagrantfile has been fully abstracted to an external file called shelters.yaml. Anything you need, from a default box to provisioner settings to AWS account information has been coded into this vagrant file and is used in an as-needed logical way. Feel free to poke around, please comment or contribute.

<h2>shelters.yaml</h2>
This is the file you should primarily be editing. You no longer need to edit the Vagrantfile directly. (And I suggest you do not unless you really know what you are doing, you may get unexpected results). Any type of configuration Vagrant offers can be specified in this file, and I will just keep extending it until I can no longer understand what it says.

<h2>Vagrant Installation Instructions</h2>
<img src="http://www.namedevelopment.com/images/branding-calendar/Apple_LogoApril.png" width=40px height=40px style="float:left; padding: 0px;" /> 
<h3>Mac Users:</h3>
Note: The ruby version Macs ship with will NOT work with the vagrant-aws plugin, I strongly recommend following the 
instructions below.<br/>
<ol>
<li>Install VirtualBox: <a href="http://download.virtualbox.org/virtualbox/4.2.14/VirtualBox-4.2.14-86644-OSX.dmg">VirtualBox-4.2.14.dmg</a><br/></li>
<li>Install <a href="http://developer.apple.com/downloads">Command Line Tools for Xcode</a>, you will need your Apple ID.<br/></li>
<li>Install git <a href="http://git-scm.com/download/mac">Git for Mac</a><br/></li>
<li>Install RVM for installing Ruby (backslash included):<br/>
<code>\curl -L https://get.rvm.io | bash</code><br/></li>
<li>Configure RVM for use:<br/>
<code>source ~/.rvm/scripts/rvm</code><br/></li>
<li>Install ruby:<br/>
<code>rvm install 1.9.3</code><br/></li>
<li>Install <a href="http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/Vagrant-1.2.2.dmg">Vagrant-1.2.2.dmg</a><br/></li>
<li>Install vagrant-aws plugin:<br/>
<code>vagrant plugin install vagrant-aws</code><br/></li>
<li>Clone my vagrant_shelters repo:<br/>
<code>git clone https://github.com/jedmunds/vagrant/</code></li>
<li>cd into the directory:<br/>
<code>cd vagrant_shelters</code><br/></li>
<li>Edit the shelters.yaml file to include your local paths rather than mine.<br/></li>
<li>Run vagrant up environment, where environment is a name in the shelters.yaml file or a custom VM name. For instance:<br/>
<code>vagrant up confluence</code><br/></li>
<li>If you want to bring up machines with AWS, append --provider=aws to your 'vagrant someCommand someEnvironment' commands, and it should just 'work'.<br/>
<code>vagrant up confluence --provider=aws</code><br/></li>
</ol>

<h3>Windows Users:</h3>
Note: This is not for the feint of heart, as you may encounter one or two (or seven) errors along the way. <br/>
<ol>
<li>Install VirtualBox: <a href="http://download.virtualbox.org/virtualbox/4.2.12/VirtualBox-4.2.12-84980-Win.exe">VirtualBox-4.2.12.dmg</a> No other version will work!<br/></li>
<li>Install ruby: <a href="http://rubyforge.org/frs/download.php/76956/rubyinstaller-2.0.0-p195-x64.exe">Ruby 2.0.0</a> and select 'add ruby binaries to PATH.</li>
<li>Install Vagrant: <a href="http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/Vagrant_1.2.2.msi">Vagrant for Windows</a><br/></li>
<li>Install MinGW, checking all boxes during installation: <a href="http://sourceforge.net/projects/mingw/files/Installer/mingw-get-inst/mingw-get-inst-20120426/mingw-get-inst-20120426.exe/download">MinGW Linux Commands</a></li>
<li>Install git for Windows: <a href="https://code.google.com/p/msysgit/downloads/detail?name=Git-1.8.3-preview20130601.exe&can=1&q=full+installer+official+git">Git for Windows</a></li>
<li>Clone my repo:<br/>
<code>git clone https://github.com/jedmunds/vagrant.git</code></li>
<li>cd into my repo directory<br/>
<code>cd vagrant</code></li>
<li>Install vagrant-aws plugin:<br/>
<code>vagrant plugin install vagrant-aws</code></li>
<li>Edit the shelters.yaml file to include your local paths rather than mine.<br/></li>
<li>Run vagrant up environment, where environment is a name in the shelters.yaml file or a custom VM name. For instance:<br/>
<code>vagrant up confluence</code><br/></li>
<li>If you want to bring up machines with AWS, append --provider=aws to your 'vagrant someCommand someEnvironment' commands, and it should just 'work'.<br/>
<code>vagrant up confluence --provider=aws</code><br/></li>
</ol>

<h2>FAQ</h2>

<strong>Will the Vagrantfile work by itself?</strong>
No, with such heavy parameterization the Vagrantfile needs the shelters.yaml file to work (at all)

<strong>What's with all the weird-looking code in your Vagrantfile?</strong>
Vagrantfiles are written in ruby, and all the weird-looking code is just 'extra' ruby.

<strong>Why should I use your Vagrantfile? I'll just write my own!</strong>
Please do! Playing with vagrant is fun, and I don't intend to deprive anyone of the opportunity. However, for those that want a working, cross-platform, scalable solution, I suggest at least skimming over my Vagrantfile.
