vagrant
=======

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
<code>source ~/.rvm/scripts/ram</code><br/></li>
<li>Install ruby:<br/>
<code>rvm install ruby</code><br/></li>
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

<h2>FAQ</h2>

<strong>Will the Vagrantfile work by itself?</strong>
No, with such heavy parameterization the Vagrantfile needs the shelters.yaml file to work (at all)

<strong>What's with all the weird-looking code in your Vagrantfile?</strong>
Vagrantfiles are written in ruby, and all the weird-looking code is just 'extra' ruby.
