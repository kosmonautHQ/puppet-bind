# Defined type allows you to declare a BIND zone.
#
# Usage:
#
# bind::zone { 'example.com':
#   ensure  => present,
#   content =>
#        [ 'type master',
#          'file "/etc/bind/zones/example.com."', ]
# }
#
define bind::zone (
    String $ensure                = present,
    Stdlib::Absolutepath $cfg_dir = $bind::params::cfg_dir,
    Array $content                = [],
) {
    include bind::params

    concat::fragment{ "named.conf.local.${title}.include":
        target  => "${cfg_dir}/named.conf.local",
        order   => 2,
        content => template("${module_name}/zone.erb"),
    }
}
