# == Class: audit::params
#
class audit::params {

  case $::architecture
  {
    'x86_64': { $arch64=true }
    'amd64': { $arch64=true }
    default: {$arch64=false }
  }

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
          $service_restart = '/etc/init.d/auditd restart'
          $service_stop = '/etc/init.d/auditd stop'
        }
        /^7.*$/:
        {
          $audit_file='/etc/audit/rules.d/eyp-audit.rules'
          $service_restart = '/usr/libexec/initscripts/legacy-actions/auditd/restart'
          $service_stop = '/usr/libexec/initscripts/legacy-actions/auditd/stop'
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
              $service_restart = '/etc/init.d/auditd restart'
              $service_stop = '/etc/init.d/auditd stop'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      $pkg_audit='audit'
      $sysconfig=true
      case $::operatingsystem {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            '11.3':
            {
              $audit_file='/etc/audit/audit.rules'
              $service_restart = '/etc/init.d/auditd restart'
              $service_stop = '/etc/init.d/auditd stop'
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
