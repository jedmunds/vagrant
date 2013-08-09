class pvops_ruby::params {
  $ruby_url = 'http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-1.9.3-p448.exe'
  $rvm_url = "https://get.rvm.io"
  case $::operatingsystem {
    centos, redhat: {
      case $::architecture {
        x86_64, amd64: {
          $ruby_provider = "rpm"
          $wget_curl = "curl -L"
        }   
        i386: {
          $ruby_provider = "rpm"
          $wget_curl = "curl -L"
        }   
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }   
      }   
    }   
    debian, ubuntu: {
      case $::architecture {
        x86_64, amd64: {
          $ruby_provider = "deb"
          $ruby_present = "absent"
          $wget_curl = "wget"
        }   
        i386: {
          $ruby_provider = "deb"
          $ruby_present = "absent"
          $wget_curl = "wget"
        }   
        default: {
          fail("Unrecognized architecture: ${::architecture}")
        }   
      }   
    }   
    darwin: {
      $ruby_provider = "pkgdmg"
      $wget_curl = "curl -L"
    }   
    windows: {
      $ruby_provider = "windows"
      $wget_curl = "curl -L"
    }   
    default: {
      fail("Unrecognized operating system: ${::operatingsystem}")
    }   

  }
}
