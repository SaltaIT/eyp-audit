class audit::audisp::install inherits audit::audisp {

  if($audit::audisp::manage_package)
  {
    package { $audit::params::audispd_package:
      ensure => $audit::audisp::package_ensure,
    }
  }
}
