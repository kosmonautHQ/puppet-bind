# == Class: bind::service
#
# This class manages parameters for ISC Bind.
#
# This class should not be used directly under normal circumstances
# Instead, use the *bind* class.
#
class bind::service (
    String $service = $bind::params::service
) inherits bind::params {

    service { $service:
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
    }

}
