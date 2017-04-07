# == Class: bind
#
# === Examples
#
#  class { 'bind':
<<<<<<< HEAD
#    listen_on       => '{ 127.0.0.1; }',
=======
#    listen_on       => '192.168.1.105',
>>>>>>> 5f56e230a3aab4480672726046a89461373bf29b
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
<<<<<<< HEAD
  $package_name           = $::bind::params::package_name,
  $config_file            = $::bind::params::config_file,
  $template               = 'bind/configfile.erb',
  $template_local         = $::bind::params::template_local,
  $acl                    = [],
  $listen_on              = undef,
  $listen_on_v6           = undef,
  $directory              = undef,
  $dump_file              = undef,
  $statistics_file        = undef,
  $memstatistics_file     = undef,
  $allow_query            = undef,
  $allow_update           = undef,
  $allow_transfer         = undef,
  $blackhole              = undef,
  $recursion              = undef,
  $allow_recursion        = undef,
  $dnssec_enable          = undef,
  $dnssec_validation      = undef,
  $bindkeys_file          = undef,
  $managed_keys_directory = undef,
  $pid_file               = undef,
  $session_keyfile        = undef,
  $auth_nxdomain          = undef,
  $logging                = undef,
  $zone                   = [],
  $include                = [],
=======
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
>>>>>>> 5f56e230a3aab4480672726046a89461373bf29b
) inherits ::bind::params {
  package { $package_name: ensure => installed }
  file { $config_file:
    require => package[$package_name],
<<<<<<< HEAD
    backup  => '.backup',
    content => template($template),
  }
=======
    content => template($template),
  }
  if $::osfamily == 'Debian' {
    file { '/etc/bind/named.conf.local':
      require => package[$package_name],
      content => template($template_local),
    }
  }
>>>>>>> 5f56e230a3aab4480672726046a89461373bf29b
  if $::osfamily == 'RedHat' {
    service { 'named':
      require => package[$package_name],
      enable  => true,
    }
  }
}
