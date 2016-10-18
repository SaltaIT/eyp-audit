# == Class: audit
#
class audit (
              $buffers              = '320',
              $add_default_rules    = true,
              $manage_logrotate     = true,
              $logrotate_rotate     = '4',
              $logrotate_compress   = true,
              $logrotate_missingok  = true,
              $logrotate_notifempty = true,
            ) inherits audit::params {

  package { $audit::params::pkg_audit:
    ensure => 'installed',
  }

  service { 'auditd':
    ensure    => 'running',
    enable    => true,
    require   => Package[$audit::params::pkg_audit],
    restart   => $audit::params::service_restart,
    stop      => $audit::params::service_stop,
    hasstatus => true,
  }

  concat { $audit::params::audit_file:
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    notify => Service['auditd'],
  }

  concat::fragment{ "${audit::params::audit_file} base":
    target  => $audit::params::audit_file,
    order   => '00',
    content => template("${module_name}/base_audit.erb"),
  }

  if($add_default_rules)
  {
    concat::fragment{ "${audit::params::audit_file} default rules":
      target  => $audit::params::audit_file,
      order   => '01',
      content => template("${module_name}/default_rules.erb"),
    }
  }

  if($manage_logrotate)
  {
    logrotate::logs { 'audit':
      ensure        => present,
      log           => [ '/var/log/audit/audit.log' ],
      rotate        => '4',
      compress      => true,
      missingok     => true,
      notifempty    => true,
    }
  }
}
