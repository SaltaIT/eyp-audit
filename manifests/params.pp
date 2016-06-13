# == Class: audit::params
#
class audit::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-7].*$/:
        {
          $pkg_audit='audit'
          $sysconfig=true
        }
        default: { fail("Unsupported RHEL/CentOS version! - $::operatingsystemrelease")  }
      }

    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $pkg_audit='auditd'
              $sysconfig=false
            }
            default: { fail("Unsupported Ubuntu version! - $::operatingsystemrelease")  }
          }
        }
        'Debian': { fail("Unsupported")  }
        default: { fail("Unsupported Debian flavour!")  }
      }
    }
    default: { fail("Unsupported OS!")  }
  }
}
