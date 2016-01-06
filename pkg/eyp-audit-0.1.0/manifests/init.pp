# == Class: audit
#
class audit inherits audit::params {

  package { $pkg_audit:
    ensure => 'installed',
  }

  service { 'auditd':
    ensure  => 'running',
    enable  => true,
    require => Package[$pkg_audit],
  }


}
