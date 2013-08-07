class pvops_vagrant (
  $vagrant_url = $pvops_vagrant::params::vagrant_url,
  $vagrant_provider = $pvops_vagrant::params::vagrant_provider,
  $vagrant_path = $pvops_vagrant::params::vagrant_path,
) inherits pvops_vagrant::params {

  package { 'vagrant':
    ensure => installed,
    provider => $vagrant_provider,
    source => $vagrant_url,
  }

  file { 'ops_puppet':
    ensure => directory,
    source => "http://github.com/jedmunds/vagrant",
    path => '/Users/jordanedmunds/ops_puppet',
  }
   
  file { 'Vagrantfile':
    ensure => present,
    path => "${vagrant_path}/Vagrantfile",
    source => $vagrantfile_source
  }

  file { 'shelters.yaml':
    ensure => present,
    path => "${vagrant_path}shelters.yaml"
  }
  
}
