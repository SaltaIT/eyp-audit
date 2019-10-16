# == Class: audit
#
# audit.rules concat
#
# 00 header
# 01 default rules
# 02 default security rules
# 10 fsrules
# 11 syscallrules
#
class audit (
              $buffers                = '320',
              $add_default_rules      = true,
              $manage_logrotate       = true,
              $logrotate_rotate       = '4',
              $logrotate_compress     = true,
              $logrotate_missingok    = true,
              $logrotate_notifempty   = true,
              $logrotate_frequency    = 'weekly',
              $log_alter_time         = false,
              $log_dac                = false,
              $log_netconf_changes    = false,
              $log_file_deletions     = false,
              $log_export_media       = false,
              $log_kmod_load_unload   = false,
              $log_priv_commands      = false,
              $log_changes_login_logs = false,
              $log_format             = 'RAW',
              $tcp_listen_port        = undef,
              $flush                  = $audit::params::flush_default,
              $manage_auditconf       = true,
              $auditd_specifics       = true,
              $log_dir                = '/var/log/audit',
            ) inherits audit::params {

  package { $audit::params::pkg_audit:
    ensure => 'installed',
  }

  file { $log_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    require => Package[$audit::params::pkg_audit],
    before  => File['/etc/audit/auditd.conf'],
  }

  if($manage_auditconf)
  {
    file { '/etc/audit/auditd.conf':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => template("${module_name}/auditdconf.erb"),
      require => Package[$audit::params::pkg_audit],
      notify  => Service['auditd']
    }
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

  if($log_alter_time)
  {
    concat::fragment{ "${audit::params::audit_file} log_alter_time":
      target  => $audit::params::audit_file,
      order   => '02a',
      content => template("${module_name}/rules/clock_settime.erb"),
    }
  }

  if($log_dac)
  {
    concat::fragment{ "${audit::params::audit_file} log_dac":
      target  => $audit::params::audit_file,
      order   => '02b',
      content => template("${module_name}/rules/dac.erb"),
    }
  }

  if($log_netconf_changes)
  {
    concat::fragment{ "${audit::params::audit_file} log_netconf_changes":
      target  => $audit::params::audit_file,
      order   => '02c',
      content => template("${module_name}/rules/netconf.erb"),
    }
  }

  if($log_file_deletions)
  {
    concat::fragment{ "${audit::params::audit_file} log_file_deletions":
      target  => $audit::params::audit_file,
      order   => '02d',
      content => template("${module_name}/rules/file_deletions.erb"),
    }
  }

  if($log_export_media)
  {
    concat::fragment{ "${audit::params::audit_file} log_export_media":
      target  => $audit::params::audit_file,
      order   => '02e',
      content => template("${module_name}/rules/export_media.erb"),
    }
  }

  if($log_kmod_load_unload)
  {
    concat::fragment{ "${audit::params::audit_file} log_kmod_load_unload":
      target  => $audit::params::audit_file,
      order   => '02f',
      content => template("${module_name}/rules/kmod_load_unload.erb"),
    }
  }

  if($log_priv_commands)
  {
    concat::fragment{ "${audit::params::audit_file} log_priv_commands":
      target  => $audit::params::audit_file,
      order   => '02g',
      content => template("${module_name}/rules/priv_commands.erb"),
    }
  }

  if($log_changes_login_logs)
  {
    concat::fragment{ "${audit::params::audit_file} log_changes_login_logs":
      target  => $audit::params::audit_file,
      order   => '02h',
      content => template("${module_name}/rules/logins.erb"),
    }
  }

  if($manage_logrotate)
  {
    include ::logrotate

    logrotate::logs { 'audit':
      ensure     => 'present',
      log        => [ "${log_dir}/audit.log" ],
      rotate     => $logrotate_rotate,
      compress   => $logrotate_compress,
      missingok  => $logrotate_missingok,
      notifempty => $logrotate_notifempty,
      frequency  => $logrotate_frequency,
    }
  }
}
