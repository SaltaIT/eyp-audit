class audit::audisp (
                      $manage_package        = true,
                      $package_ensure        = 'installed',
                      $manage_service        = true,
                      $manage_docker_service = true,
                      $service_ensure        = 'running',
                      $service_enable        = true,
                    ) inherits audit::params
{

  include ::audit

  Class['::audit'] ->
  class { '::audit::audisp::install': } ->
  class { '::audit::audisp::config': } ->
  Class['::audit::audisp']

}
