# == Class: bind
#
# This module is used to install and manage ISC Bind.
#
# See README.md for more details
#
class bind (
    Array $acl                                             = [],
    Array $allow_query                                     = [],
    Array $allow_query_cache                               = [],
    Array $allow_recursion                                 = [],
    Array $allow_transfer                                  = [],
    Array $allow_update                                    = [],
    String $auth_nxdomain                                  = undef,
    Optional[Stdlib::Absolutepath] $bindkeys_file          = undef,
    $blackhole                                             = undef,
    $cleaning_interval                                     = undef,
    Stdlib::Absolutepath $directory                        = $bind::params::directory,
    $dnssec_enable                                         = undef,
    String $dnssec_validation                              = 'auto',
    Optional[Stdlib::Absolutepath] $dump_file              = undef,
    Boolean $empty_zones_enable                            = true,
    $forward_policy                                        = undef,
    Array $forwarders                                      = [],
    $interface_interval                                    = undef,
    Array $key                                             = [],
    Array $listen_on                                       = [],
    Array $listen_on_v6                                    = [],
    Hash $log_channels                                     = {},
    Hash $log_categories                                   = {},
    Optional[Stdlib::Absolutepath] $managed_keys_directory = undef,
    $max_ncache_ttl                                        = undef,
    Optional[Stdlib::Absolutepath] $memstatistics_file     = undef,
    $query_log_enable                                      = undef,
    Hash $records                                          = {},
    $recursion                                             = undef,
    $request_ixfr                                          = undef,
    $server_id                                             = undef,
    $session_keyfile                                       = undef,
    Optional[Array] $statistics_channels                   = [],
    Optional[Stdlib::Absolutepath] $statistics_file        = undef,
    Optional[String] $version                              = undef,
    Optional[Hash] $zones                                  = {},
    Optional[String] $zone_notify                          = undef,
    Optional[String] $zone_statistics                      = undef,
) inherits bind::params {

    $valid_forward_policy = ['first', 'only']
    if $forward_policy != undef and !member($valid_forward_policy, $forward_policy) {
        fail("The forward_policy must be ${valid_forward_policy}")
    }

    file { "${cfg_dir}/named.conf.options":
        backup  => '.backup',
        content => template("${module_name}/named.conf.options.erb"),
        ensure  => present,
        group   => $bind::params::group,
        mode    => '0644',
        owner   => $bind::params::owner,
        require => Class['bind::install'],
    }

    concat { "${cfg_dir}/named.conf.local":
        owner  => $bind::params::owner,
        group  => $bind::params::group,
        mode   => '0644',
    }

    concat::fragment{'named.conf.local.header':
        target  => "${cfg_dir}/named.conf.local",
        order   => 1,
        content => template("${module_name}/named.conf.local.erb"),
    }

    contain bind::install
    contain bind::records
    contain bind::service
    contain bind::zones

    Class['::bind::install']
    -> Class['::bind::records']
    -> Class['::bind::service']
    -> Class['::bind::zones']
}
