class bind::params {
  if $::osfamily == 'RedHat' {
    $package_name = [ 'bind', 'bind-chroot' ]
    $config_file  = '/etc/named.conf'
    $zonedir = '/var/named/'
    $zonegroup = 'named'
    case $::operatingsystemrelease {
      /^6.*/: {
        $template = 'bind/named.conf.c.6.erb'
        $template_local = undef
      }
      /^7.*/: {
        $template = 'bind/named.conf.c.7.erb'
        $template_local = undef
      }
      default: {
        $template = 'bind/named.conf.c.6.erb'
        $template_local = undef
      }
    }
  }
  elsif $::osfamily == 'Debian' {
    $package_name = [ 'bind9' ]
    $config_file = '/etc/bind/named.conf.options'
    $zonedir = '/etc/bind/zones/'
    $zonegroup = 'bind'
    case $::operatingsystemrelease {
      /^12.*/: {
        $template = 'bind/named.conf.options.u.12.erb'
        $template_local = 'bind/named.conf.local.u.12.erb'
      }
      /^14.*/: {
        $template = 'bind/named.conf.options.u.14.erb'
        $template_local = 'bind/named.conf.local.u.14.erb'
      }
      /^16.*/: {
        $template = 'bind/named.conf.options.u.16.erb'
        $template_local = 'bind/named.conf.local.u.16.erb'
      }
      default: {
        $template = 'bind/named.conf.options.u.12.erb'
        $template_local = 'bind/named.conf.local.u.12.erb'
      }
    }
  }
}
