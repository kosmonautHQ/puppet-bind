# == Class: bind::records
#
# This class applies user-defined records for ISC Bind zones.
#
class bind::records {

    assert_private()

    $records = hiera_hash('bind::records', {})
    create_resources('bind::record', $records)

}
