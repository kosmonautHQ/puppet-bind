# == Class: bind
#
# === Examples
#
#  class { 'bind':
#    listen_on       => '192.168.1.105',
#    zone            => {
#      'example.com' => [
#        'type master',
#        'file "/etc/bind/zones/example.com.db"',
#      ],
#    },
#  }
#
# === Authors
#
# Aneesh C <aneeshchandrasekharan@gmail.com>
#

class bind (
  $package_name   = $::bind::params::package_name,
  $template       = $::bind::params::template,
  $template_local = $::bind::params::template_local,
  $config_file    = $::bind::params::config_file,
  $acl            = [],
  $listen_on      = undef,
  $allow_query    = 'localhost',
  $allow_update   = 'none',
  $allow_transfer = 'none',
  $recursion      = 'no',
  $blackhole      = undef,
  $zone           = [],
) inherits ::bind::params {
  package { $package_name: ensure => installed }
  file { $config_file:
    require => package[$package_name],
    content => template($template),
  }
  if $::osfamily == 'Debian' {
    file { '/etc/bind/named.conf.local':
      require => package[$package_name],
      content => template($template_local),
    }
  }
  if $::osfamily == 'RedHat' {
    service { 'named':
      require => package[$package_name],
      enable  => true,
    }
  }
}
