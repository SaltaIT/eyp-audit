class { 'audit':
  add_default_rules => false,
  buffers           => '600',
  tcp_listen_port   => '60',
}
