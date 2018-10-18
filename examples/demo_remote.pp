class { 'audit':
  add_default_rules => true,
  buffers           => '600',
  tcp_listen_port   => '60',
}
