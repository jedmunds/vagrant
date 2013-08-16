class pvops_virtualbox (
  $virtualbox_url = $pvops_virtualbox::params::virtualbox_url,
  $virtualbox_provider = $pvops_virtualbox::params::virtualbox_provider,
) inherits pvops_virtualbox::params {

  package { 'virtualbox':
    ensure   => installed,
    provider => $virtualbox_provider,
    source   => $virtualbox_url,
  }
}
