class pvops_vagrant (

  $vagrant_url = $pvops_vagrant::params::vagrant_url,
  $vagrant_provider = $pvops_vagrant::params::vagrant_provider,
  $vagrant_binary = $pvops_vagrant::params::vagrant_binary,

) inherits pvops_vagrant::params {

  package { 'vagrant':
    ensure   => installed,
    source   => $vagrant_url,
    provider => $vagrant_provider,
  }

  #exec { 'vagrant-aws':
  #  command => "/usr/bin/vagrant plugin install vagrant-aws",
  #  cwd => "/Users/jordanedmunds/dev/work/vagrant/",
  #  require => Package['vagrant'],
  #}

}
