# == Class: bind::install
#
# This class manages the installation of ISC Bind.
#
# This class should not be used directly under normal circumstances
# Instead, use the *bind* class.
#
class bind::install (
    Array $necessary_packages = $bind::params::necessary_packages,
    String $ensure_packages    = $bind::params::ensure_packages,
) inherits bind::params {

    package { $necessary_packages :
        ensure => $ensure_packages,
    }

}
