define audit::customfile(
                          $source = undef,
                          $content = undef,
                          $filename = $name,
                          $ensure   = 'present',
                        ) {
  include ::audit

  if($audit::params::auditd_dir==undef)
  {
    fail('Unable to set custom rules using audit::customfile on this OS')
  }

  file { "${audit::params::auditd_dir}/${filename}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    require => Package[$audit::params::pkg_audit],
    notify  => Service['auditd'],
    source  => $source,
    content => $content,
  }
}
