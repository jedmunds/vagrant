class pvops_ruby (
  
  $ruby_url = $pvops_ruby::params::ruby_url,
  $rvm_url = $pvops_ruby::params::rvm_url,
  $wget_curl = $pvops_ruby::params::wget_curl,
  $ruby_provider = $pvops_ruby::params::ruby_provider,

) inherits pvops_ruby::params {

  package { 'ruby':
    ensure   => present,
    source   => $ruby_url,
    provider => $ruby_provider,
  }

  exec { 'download-rvm':
    command => "/usr/bin/${wget_curl} ${rvm_url}",
  }

  file { 'rvm':
    mode => '0755',
    path => '/Users/jordanedmunds/.rvm/scripts/rvm',
    require => Exec['download-rvm'],
  }

  exec { 'install-ruby':
    command => "/Users/jordanedmunds/.rvm/bin/rvm install 1.9.3",
    require => File['rvm'],
  }

}
