class pvops_virtualbox::params {
  case $::operatingsystem {
    centos, redhat: {
      case $::architecture {
        x86_64, amd64: {
          $virtualbox_url = 'http://download.virtualbox.org/virtualbox/4.2.16/VirtualBox-4.2-4.2.16_86992_fedora18-1.x86_64.rpm'
          $virtualbox_provider = 'rpm'
        }   
        i386: {
          $virtualbox_url = 'http://download.virtualbox.org/virtualbox/4.2.16/VirtualBox-4.2-4.2.16_86992_fedora18-1.i686.rpm'
          $virtualbox_provider = 'rpm'
        }   
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }   
      }   
    }   
    debian, ubuntu: {
      case $::architecture {
        x86_64, amd64: {
          $virtualbox_url = 'http://download.virtualbox.org/virtualbox/4.2.16/virtualbox-4.2_4.2.16-86992~Debian~wheezy_amd64.deb'
          $virtualbox_provider = 'apt'
        }   
        i386: {
          $virtualbox_url = 'http://download.virtualbox.org/virtualbox/4.2.16/virtualbox-4.2_4.2.16-86992~Debian~wheezy_i386.deb'
          $virtualbox_provider = 'apt'
        }   
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }   
      }   
    }   
    darwin: {
      $virtualbox_url = 'http://download.virtualbox.org/virtualbox/4.2.16/VirtualBox-4.2.16-86992-OSX.dmg'
      $virtualbox_provider = 'pkgdmg'
    }   
    windows: {
      $virtualbox_url = 'http://download.virtualbox.org/virtualbox/4.2.12/VirtualBox-4.2.12-84980-Win.exe'
      $virtualbox_provider = 'windows'
    }   
    default: {
      fail("Unrecognized operating system: ${::operatingsystem}")
    }   

  }
}
