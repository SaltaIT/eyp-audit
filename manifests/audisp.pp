class audit::audisp (
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $manage_service        = true,
                      $manage_docker_service = true,
                      $service_ensure        = 'running',
                      $service_enable        = true,
                      $remote_server         = undef,
                      $remote_port           = '60',
                      $queue_file            = '/var/spool/audit/remote.log',
                      $queue_depth           = '2048',
                    ) inherits audit::params {
  include ::audit

  Class['::audit'] ->
  class { '::audit::audisp::install': } ->
  class { '::audit::audisp::config': } ->
  Class['::audit::audisp']

}
