class profiles::gitlab::server (
  Stdlib::Httpurl                $external_url                    = "http://${facts['networking']['fqdn']}",
  Optional[Hash]                 $gitlab_rails                    = {},
  Optional[Hash]                 $sidekiq                         = undef,
) {

  class { 'gitlab':
    external_url                    => $external_url,    
  }

  $gitlab_init = '[Unit]
  Description=GitLab Runit supervision process
  After=network.target
  
  [Service]
  ExecStart=/opt/gitlab/embedded/bin/runsvdir-start
  Restart=always
  
  [Install]
  WantedBy=network.target'

  file { '/etc/systemd/system/gitlab-runsvdir.service':
    ensure  => 'file',
    content => $gitlab_init,
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    notify  => Exec['systemctl-daemon-reload'],
    before  => Class['gitlab'],
  }

  group { 'git':
    ensure => 'present',
  }

  user { 'git':
    ensure             => 'present',
    gid                => 'git',
    home               => '/var/opt/gitlab',
    password           => '!!',
    password_max_age   => -1,
    password_min_age   => -1,
    shell              => '/bin/sh',
    uid                => 995,
    require            => Group['git'],
  }
  
}
