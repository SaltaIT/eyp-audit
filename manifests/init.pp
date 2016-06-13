# == Class: audit
#
class audit (
              $buffers='320',
              $add_default_rules=true,
            ) inherits audit::params {

  package { $audit::params::pkg_audit:
    ensure => 'installed',
  }

  service { 'auditd':
    ensure  => 'running',
    enable  => true,
    require => Package[$audit::params::pkg_audit],
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



}
