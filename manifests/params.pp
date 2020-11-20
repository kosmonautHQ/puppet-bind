# == Class: bind::params
#
# This class manages parameters for ISC Bind.
#
# This class should not be used directly under normal circumstances
# Instead, use the *bind* class.
#
class bind::params {
    case $::osfamily {
        'Debian': {
            $cfg_dir            = '/etc/bind'
            $group              = 'bind'
            $necessary_packages = [ 'bind9', 'bind9utils' ]
            $owner              = 'bind'
            $service            = 'bind9'
            $working_dir        = '/var/cache/bind'
            $zonefile_dir       = "${cfg_dir}/zones"
        }
        'RedHat': {
            $cfg_dir            = '/etc'
            $group              = 'named'
            $necessary_packages = [ 'bind', ]
            $owner              = 'named'
            $service            = 'named'
            $working_dir        = '/var/named'
            $zonefile_dir       = "${working_dir}/data"
        }
        default: {
            fail("This module is incompatible with this osfamily: ${::osfamily}")
        }
    }
    $ensure_packages = latest
}
