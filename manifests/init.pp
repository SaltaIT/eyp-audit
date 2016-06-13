# == Class: audit
#
class audit (
              $buffers='320',
              $add_default_rules=true
            ) inherits audit::params {

  package { $audit::params::pkg_audit:
    ensure => 'installed',
  }

  service { 'auditd':
    ensure  => 'running',
    enable  => true,
    require => Package[$audit::params::pkg_audit],
  }

  concat { '/etc/audit/audit.rules':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    notify => Service['auditd'],
  }

  concat::fragment{ '/etc/audit/audit.rules base':
    target  => '/etc/audit/audit.rules',
    order   => '00',
    content => template("${module_name}/base_audit.erb"),
  }

  if($add_default_rules)
  {
    concat::fragment{ '/etc/audit/audit.rules default rules':
      target  => '/etc/audit/audit.rules',
      order   => '01',
      content => template("${module_name}/default_rules.erb"),
    }
  }



}
