$:.unshift File.expand_path("../command", __FILE__)
require "vagrant"

Gem::Specification.new do |s|
  s.name        = "vagrant-shelters"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Jordan Edmunds"
  s.email       = "jedmunds24t@gmail.com"
  s.hopepage    = "http://pv.com"
  s.summary     = "Enables Vagrant to use directories outside the working one."
  s.discription = "Enables Vagrant to use directories outside the working one."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "vagrant-shelters"

  s.add_runtime_dependency "fog", "~> 1.10.0"

  s.add_development_dependency "rake"
  # The following block of code determines the files that should be included
  # in the gem. It does this by reading all the files in the directory where 
  # this gemspec is, and parsing out the ignored files from the gitignore.
  # Note that the entire gitignore(5) syntax is not supported, specifically
  # the "!" syntax, but it should mostly work correctly.
  root_path     = File.dirname(__FILE__)
  all_files     = Dir.chdir(root_path) {Dir.glob("**/{*,.*}") }

  s.files = all_files
end
