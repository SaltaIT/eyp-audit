# == Class: audit::params
#
class audit::params {

  case $::osfamily
  {
    'redhat':
    {
      $pkg_audit='audit'
      $sysconfig=true
      case $::operatingsystemrelease
      {
        /^[5-6].*$/:
        {
          $audit_file='/etc/audit/audit.rules'
        }
        /^7.*$/:
        {
          $audit_file='/etc/audit/rules.d/eyp-audit.rules'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
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
              $audit_file='/etc/audit/audit.rules'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
