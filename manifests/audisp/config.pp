class audit::audisp::config inherits audit::audisp {

  # /etc/audisp/audisp-remote.conf
  file { '/etc/audisp/audisp-remote.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/audisp/remote.erb"),
  }

}
