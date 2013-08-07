class pvops_vagrant::params {
  case $::operatingsystem {
    centos, redhat: {
      case $::architecture {
        x86_64, amd64: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64.rpm'
          $vagrant_provider = 'rpm'
          $vagrant_path = "/home/${::id}/ops_puppet/vagrant/"
        }   
        i386: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_i686.rpm'
          $vagrant_provider = 'rpm'
          $vagrant_path = "/home/${::id}/ops_puppet/vagrant/"
        }   
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }   
      }   
    }   
    debian, ubuntu: {
      case $::architecture {
        x86_64, amd64: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64.deb'
          $vagrant_provider = 'apt'
          $vagrant_path = "/home/${::id}/ops_puppet/vagrant/"
        }   
        i386: {
          $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_i686.deb'
          $vagrant_provider = 'apt'
          $vagrant_path = "/home/${::id}/ops_puppet/vagrant/"
        }   
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }   
      }   
    }   
    darwin: {
      $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/Vagrant-1.2.2.dmg'
      $vagrant_provider = 'pkgdmg'
      $vagrant_path = "/Users/${::id}/ops_puppet/vagrant/"
    }   
    windows: {
      $vagrant_url = 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/Vagrant_1.2.2.msi'
      $vagrant_provider = 'msi'
      $vagrant_path = "/Users/${::id}/ops_puppet/vagrant/"
    }   
    default: {
      fail("Unrecognized operating system: ${::operatingsystem}")
    }   

  }
}
