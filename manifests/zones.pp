# == Class: bind::zones
#
# This class applies user-defined zones for ISC Bind.
#
class bind::zones {

    assert_private()

    $zones = hiera_hash('bind::zones', {})
    create_resources('bind::zone', $zones)

}
