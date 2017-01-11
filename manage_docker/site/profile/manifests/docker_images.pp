class profile::docker_images {
  class { 'docker':
    tcp_bind    => ["${::ipaddress}4243", '127.0.0.1:4243'],
    socket_bind => 'unix:///var/run/docker.sock',
    ip_forward  => true,
  }
}
