# == Class: audit::params
#
class audit::params {

  case $::architecture
  {
    'x86_64': { $arch64=true }
    'amd64': { $arch64=true }
    default: { $arch64=false }
  }

  case $::osfamily
  {
    'redhat':
    {
      $pkg_audit='audit'
      $sysconfig=true
      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
          $audit_file='/etc/audit/audit.rules'
          $service_restart = '/etc/init.d/auditd restart'
          $service_stop = '/etc/init.d/auditd stop'
          $audispd_package=undef
          $flush_default = 'INCREMENTAL'
        }
        /^7.*$/:
        {
          $audit_file='/etc/audit/rules.d/eyp-audit.rules'
          $service_restart = '/usr/libexec/initscripts/legacy-actions/auditd/restart'
          $service_stop = '/usr/libexec/initscripts/legacy-actions/auditd/stop'
          $audispd_package='audispd-plugins'
          $flush_default = 'INCREMENTAL_ASYNC'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }

    }
    'Debian':
    {
      $pkg_audit='auditd'
      $sysconfig=false

      $audispd_package=undef

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $audit_file='/etc/audit/audit.rules'
              $service_restart = '/etc/init.d/auditd restart'
              $service_stop = '/etc/init.d/auditd stop'
              $flush_default = 'INCREMENTAL'
            }
            /^16.*$/:
            {
              $audit_file='/etc/audit/audit.rules'
              $service_restart = undef
              $service_stop = undef
              $flush_default = 'INCREMENTAL'
            }
            /^18.*$/:
            {
              $audit_file='/etc/audit/rules.d/audit.rules'
              $service_restart = undef
              $service_stop = undef
              $flush_default = 'INCREMENTAL_ASYNC'
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

      $audispd_package=undef

      case $::operatingsystem
      {
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
            '12.3':
            {
              $audit_file='/etc/audit/audit.rules'
              $service_restart = undef
              $service_stop = undef
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
