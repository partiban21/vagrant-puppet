# This class allows control of access to cron services
#
# lifted from https://github.com/shearn89/puppet-toughen
#
# See the compliance::cron class for full details all of the controls.
#
# @example Hiera configuration
# ---
#   profiles::compliance::cron::allow_users: ['root', 'admin']
#
# @param allow_users: [Array[String[]] (optional) list of usernames
#   that will be alowed to create cronjobs. Default is 'root' only.
# @param ensure: [String] (optional) Ensure state of cron daemon,
#   default is 'running' as that what CIS 5.1.1 says it should be.

class profiles::compliance::cron (
  Array[String] $allow_users = ['root'],
  String        $ensure      = 'running',
){

  service { 'crond':
    ensure => $ensure,
    enable => true,
  }

  file { '/etc/crontab':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  file { [ '/etc/cron.d',
      '/etc/cron.hourly',
      '/etc/cron.daily',
      '/etc/cron.weekly',
      '/etc/cron.monthly' ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  file { ['/etc/cron.deny', '/etc/at.deny']:
    ensure => absent,
  }

  file { '/random_file':
    ensure => file,
    content => "Hello, this is a random file\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }
}
