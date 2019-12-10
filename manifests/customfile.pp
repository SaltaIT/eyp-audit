define audit::customfile(
                          $source,
                          $filename = $name,
                          $ensure   = 'present',
                        ) {
  include ::audit

  if(!defined($audit::params::auditd_dir))
  {
    fail('Unable to set custom rules using audit::customfile on this OS')
  }

  file { '${audit::params::auditd_dir}/${filename}':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    require => Package[$audit::params::pkg_audit],
    notify  => Service['auditd'],
  }
}
