# Defined type allows you to declare records for a BIND zone.
#
# Usage:
#
# bind::records { 'example.com':
#   ensure  => present,
#   entries =>
#        [ '@      IN      NS      ns1.example.com.',
#          '@      IN      A       10.0.1.212',
#          'ns1    IN      A       10.0.1.212',
#          'www    IN      A       10.0.1.212', ],
#   serial => '00001',
#   soa => 'ns1.example.com',
#   soa_email => 'hostmaster@example.com',
#   expire => '2419200',
#   minimum => '604800',
#   refresh => '604800',
#   retry => '86400',
#   ttl => '604800',
# }
#
define bind::record (
    String $ensure                     = present,
    String $group                      = $bind::params::group,
    Array $entries                     = [],
    String $owner                      = $bind::params::owner,
    Optional[String] $serial           = undef,
    $soa                               = $::fqdn,
    $soa_email                         = "root.${::fqdn}",
    Stdlib::Absolutepath $zonefile_dir = $bind::params::zonefile_dir,
    String $expire                = '2419200',
    String $minimum               = '604800',
    String $refresh               = '604800',
    String $retry                 = '86400',
    String $ttl                   = '604800',
) {
    include bind::params

    if ! defined(File[$bind::params::zonefile_dir]) {
        file { $bind::params::zonefile_dir:
            ensure => directory,
            group  => $bind::params::group,
            owner  => $bind::params::owner,
        }
    }

    file { "${zonefile_dir}/${title}.":
        ensure  => $ensure,
        content => template("${module_name}/records.erb"),
        group   => $bind::params::group,
        mode    => '0644',
        owner   => $bind::params::owner,
        require => Class['bind::install'],
    }
}
