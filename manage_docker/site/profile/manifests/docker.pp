class profile::docker {
  class { 'docker':
    tcp_bind    => ['10.0.2.15:4243', '127.0.0.1:4243'],
    socket_bind => 'unix:///var/run/docker.sock',
    ip_forward  => true,
  } ->
  docker::image { 'ubuntu':
    image_tag => 'precise'
  } ->
  docker::run { 'helloworld':
    image   => 'ubuntu:precise',
    command => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',
  }

  class {'docker::compose':
    ensure => present,
  } ->
  file { '/etc/docker_compose':
    ensure => directory,
  } ->
  file { '/etc/docker_compose/demo.yaml':
    ensure => file,
    content => epp("${module_name}/compose_demo.epp"),
  } ->
  docker_compose { '/etc/docker_compose/demo.yaml':
    ensure => absent,
  }

}
