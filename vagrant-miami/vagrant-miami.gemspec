# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-miami/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-miami"
  spec.version       = VagrantMiamiPlugin::VERSION
  spec.authors       = ["Anentropic"]
  spec.email         = ["ego@anentropic.com"]
  spec.description   = %q{Vagrant plugin to allow you to install miamis into the Vagrant miami environment}
  spec.summary       = %q{Vagrant plugin to allow you to install miamis into the Vagrant miami environment}
  spec.homepage      = "https://github.com/anentropic/vagrant-miami"
  spec.license       = "MIT"

  spec.files         = `find .`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
