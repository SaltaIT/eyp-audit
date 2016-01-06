# == Class: tty
#
class audit::tty($enable='*') inherits audit::params {

  Exec {
    path => '/sbin:/bin:/usr/sbin:/usr/bin',
  }

  exec { 'afegint pam_tty_audit sshd':
    command => "sed '/pam_tty_audit.so/d' -i /etc/pam.d/sshd; echo 'session required pam_tty_audit.so enable=${enable}' >> /etc/pam.d/sshd",
    unless  => "grep pam_tty_audit.so /etc/pam.d/sshd",
  }


}
