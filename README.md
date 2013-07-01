vagrant
=======

This is my personal heavy modificatin of the Vagrantfile, as well as the associated shelters.yaml file and a few other pet projects.

<h2>Vagrantfile</h2>
This is an absolute butchering of what once resembled a Vagrantfile, and has been turned into a full-fledged ruby application. It is designed specifically to read parameters from a file called shelters.yaml, and allows you to heavily extend Vagrant's functionality. One of the most powerful features of this is the concept of Vagrant 'shelters', which are essentially groupings of Vagrant machine names under one 'shelter', or name. So running vagrant up environment, where environment is a custom shelters.yaml code block, brings up any amount of virtual machines with their own configurations. Cool right? Or not? I thought so, so I wrote this ^^. 

<h2>shelters.yaml</h2>
This is the file you should primarily be editing. You no longer need to edit the Vagrantfile directly. (And I suggest you do not unless you really know what you are doing, you may get unexpected results). Any type of configuration Vagrant offers can be specified in this file, and I will just keep extending it until I can no longer understand what it says.

<h2>FAQ</h2>

<strong>Will the Vagrantfile work by itself?</strong>
No, with such heavy parameterization the Vagrantfile needs the shelters.yaml file to work (at all)

<strong>What's with all the weird-looking code in your Vagrantfile?</strong>
Vagrantfiles are written in ruby, and all the weird-looking code is just 'extra' ruby.

<strong>Your code looks messy.</strong>
Sorry, I am just now learning ruby, and I'm sort of adding on things as I go, I'm also not familiar with certain ruby conventions. I will clean up the code and make it easier to read as I learn more, but for now the file is heavily commented for that reason.
