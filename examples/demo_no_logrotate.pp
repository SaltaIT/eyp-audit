class { 'audit':
  add_default_rules => true,
  buffers           => '600',
  manage_logrotate  => false,
}
